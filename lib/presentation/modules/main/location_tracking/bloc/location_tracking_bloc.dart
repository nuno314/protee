import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../common/services/auth_service.dart';
import '../../../../../common/utils/data_checker.dart';
import '../../../../../common/utils/extensions.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/notification_model.dart';
import '../../../../../data/models/response.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../interactor/location_tracking_interactor.dart';
import '../repository/location_tracking_repository.dart';

part 'location_tracking_event.dart';
part 'location_tracking_state.dart';

class RoutesInfo {
  final List<List<LatLng>> routes;
  final Viewport? bounds;

  const RoutesInfo({this.routes = const [], this.bounds});
}

class LocationTrackingBloc
    extends AppBlocBase<LocationTrackingEvent, LocationTrackingState> {
  late final _interactor = LocationTrackingInteractorImpl(
    LocationTrackingRepositoryImpl(),
  );

  final baseSocketUrl = 'ws://protee-be.herokuapp.com/';
  late Socket _socket;
  final _localDataManager = injector.get<AuthService>();

  late StreamSubscription _profileSubscription;

  LocationTrackingBloc(User? user)
      : super(
          LocationTrackingInitial(
            viewModel: _ViewModel(
              user: user,
            ),
          ),
        ) {
    on<GetPlacesEvent>(_onGetPlacesEvent);
    on<ChangeCurentLocation>(_onChangeCurentLocation);
    on<GetWarningLocationNearbyEvent>(_onGetWarningLocationNearbyEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<GetChildrenLastLocationEvent>(_onGetChildrenLastLocationEvent);
    on<GetChildrenEvent>(_onGetChildrenEvent);

    on<GetDirectionsEvent>(_onGetDirectionsEvent);
    on<SetUpSocketEvent>(_onSetUpSocketEvent);
    on<NotificationIncomingEvent>(_onNotificationIncomingEvent);

    if (user?.isParent == false || state.isParent == false) {
      add(GetPlacesEvent());
    } else {
      add(GetChildrenEvent());
      add(SetUpSocketEvent(user));
    }

    _profileSubscription =
        injector.get<AppApiService>().localDataManager.onUserChanged.listen(
      (user) {
        add(
          UpdateUserEvent(user),
        );
        add(SetUpSocketEvent(user));
      },
    );
  }

  Future<void> _onChangeCurentLocation(
    ChangeCurentLocation event,
    Emitter<LocationTrackingState> emit,
  ) async {
    if (state.user?.isParent != true) {
      emit(
        state.copyWith<CurrentLocationChangedState>(
          viewModel: state.viewModel.copyWith(latLng: event.location),
        ),
      );
    }
  }

  FutureOr<void> _onGetWarningLocationNearbyEvent(
    GetWarningLocationNearbyEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final places = await _interactor.getWarningLocationNearby(state.latLng!);

    emit(
      state.copyWith<LocationTrackingInitial>(
        viewModel: state.viewModel.copyWith(
          warningPlaces: places,
        ),
      ),
    );
  }

  FutureOr<void> _onGetPlacesEvent(
    GetPlacesEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final places = await _interactor.getPlaces();

    emit(
      state.copyWith<LocationTrackingInitial>(
        viewModel: state.viewModel.copyWith(
          places: places,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateUserEvent(
    UpdateUserEvent event,
    Emitter<LocationTrackingState> emit,
  ) {
    emit(
      state.copyWith<LocationTrackingInitial>(
        viewModel: state.viewModel.copyWith(
          user: event.user,
        ),
      ),
    );
  }

  FutureOr<void> _onGetDirectionsEvent(
    GetDirectionsEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final origin = await _interactor.getGeocode(state.latLng!);

    if (origin.isNotNullOrEmpty) {
      final res = await _interactor.getDirections(
        origin!,
        event.destination,
        state.warningPlaces,
      );
      emit(
        state.copyWith<GetRouteState>(
          viewModel: state.viewModel.copyWith(
            routes: res.routes,
            bounds: res.bounds,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onGetChildrenLastLocationEvent(
    GetChildrenLastLocationEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final res = await Future.wait<ChildLastLocation?>(
      List.generate(
        state.children.length,
        (index) => _interactor
            .getChildLastLocation(state.children.elementAt(index).id!),
      ),
      eagerError: true,
    );

    final list = List<ChildLastLocation?>.generate(
      state.children.length,
      res.elementAt,
    );

    emit(
      state.copyWith<ChildrenLastLocationState>(
        viewModel: state.viewModel.copyWith(
          lastLocations: list,
        ),
      ),
    );
  }

  FutureOr<void> _onGetChildrenEvent(
    GetChildrenEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final children = await _interactor.getChildren();
    emit(
      state.copyWith<ChildrenInitialState>(
        viewModel: state.viewModel.copyWith(
          children: children,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _profileSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onSetUpSocketEvent(
    SetUpSocketEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    if (event.user?.isParent != true) {
      return;
    }
    _socket = io(
      baseSocketUrl,
      OptionBuilder().setTransports(['websocket']).setQuery({
        'accessToken': _localDataManager.token!,
        'familyId': event.user!.familyId!,
      }).build(),
    );

    _socket.on(
      'notification',
      (data) {
        final res = asOrNull(NotificationModel.fromJson(data));
        if (res == null) {
          return;
        }
        add(NotificationIncomingEvent(res));
      },
    );
  }

  FutureOr<void> _onNotificationIncomingEvent(
    NotificationIncomingEvent event,
    Emitter<LocationTrackingState> emit,
  ) async {
    final location = event.noti.currentLocation!;
    final list = [...state.lastLocations];
    var target = list.firstWhereOrNull(
      (element) => element?.user?.id == location.user?.id,
    );

    if (target != null) {
      target = location;
    } else {
      list.add(location);
    }

    emit(
      state.copyWith<ChildrenLastLocationState>(
        viewModel: state.viewModel.copyWith(
          lastLocations: list,
        ),
      ),
    );
  }
}
