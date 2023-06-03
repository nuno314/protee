import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../interactor/account_interactor.dart';
import '../repository/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends AppBlocBase<AccountEvent, AccountState> {
  late final _interactor = AccountInteractorImpl(
    AccountRepositoryImpl(),
  );
  late StreamSubscription _profileSubscription;

  AccountBloc({User? user})
      : super(
          AccountInitial(
            viewModel: _ViewModel(
              user: user,
            ),
          ),
        ) {
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
    Emitter<AccountState> emit,
  ) async {
    emit(
      state.copyWith(
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
