import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends AppBlocBase<HomePageEvent, HomePageState> {
  late StreamSubscription _profileSubscription;
  final _restApi = injector.get<AppApiService>().client;
  final _local = injector.get<AppApiService>().localDataManager;

  HomePageBloc({User? user})
      : super(HomePageInitial(viewModel: _ViewModel(user: user))) {
    on<UpdateAccountEvent>(_onUpdateAccountEvent);
    on<InitHomePageEvent>(_onInitHomePageEvent);
    on<GetMeEvent>(_onGetMeEvent);

    _profileSubscription = _local.onUserChanged.listen(
      (user) {
        add(
          UpdateAccountEvent(user),
        );
      },
    );
  }

  Future<void> _onUpdateAccountEvent(
    UpdateAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(
      state.copyWith<HomePageInitial>(
        viewModel: state.viewModel.copyWith(user: event.user),
      ),
    );
  }

  @override
  Future<void> close() {
    _profileSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onInitHomePageEvent(
    InitHomePageEvent event,
    Emitter<HomePageState> emit,
  ) async {
    if (state.user?.isNull == true) {
      emit(
        state.copyWith<HomePageInitial>(),
      );
      return;
    }
    final res = await Future.wait(
      [
        _restApi.getBasicInformation(),
        _restApi.getFamilyMembers(),
      ],
      eagerError: true,
    );

    emit(
      state.copyWith<HomePageInitial>(
        viewModel: state.viewModel.copyWith(
          statistic: asOrNull(res[0]),
          familyMembers: asOrNull(res[1]),
        ),
      ),
    );
  }

  FutureOr<void> _onGetMeEvent(
    GetMeEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final user = await _restApi.getUserProfile();
    _local.notifyUserChanged(user);
    emit(
      state.copyWith<UserUpdatedState>(
        viewModel: state.viewModel.copyWith(
          user: user,
        ),
      ),
    );
  }
}
