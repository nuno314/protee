import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends AppBlocBase<UpdateAccountEvent, HomePageState> {
  late StreamSubscription _profileSubscription;

  HomePageBloc({User? user})
      : super(HomePageInitial(viewModel: _ViewModel(user: user))) {
    on<UpdateAccountEvent>(_onUpdateAccountEvent);

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
}
