import 'dart:async';

import 'package:bloc/bloc.dart';

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

  HomePageBloc({User? user})
      : super(HomePageInitial(viewModel: _ViewModel(user: user))) {
    on<UpdateAccountEvent>(_onUpdateAccountEvent);
    on<GetFamilyStatisticEvent>(_onGetFamilyStatisticEvent);

    _profileSubscription =
        injector.get<AppApiService>().localDataManager.onUserChanged.listen(
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

  FutureOr<void> _onGetFamilyStatisticEvent(
    GetFamilyStatisticEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final res = await _restApi.getBasicInformation();
    emit(
      state.copyWith<HomePageInitial>(
        viewModel: state.viewModel.copyWith(statistic: res),
      ),
    );
  }
}
