import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../interactor/account_interactor.dart';
import '../repository/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends AppBlocBase<AccountEvent, AccountState> {
  late final _interactor = AccountInteractorImpl(
    AccountRepositoryImpl(),
  );

  AccountBloc({User? user})
      : super(
          AccountInitial(
            viewModel: _ViewModel(
              user: user,
            ),
          ),
        ) {
    on<AccountEvent>(_onAccountEvent);
  }

  Future<void> _onAccountEvent(
    AccountEvent event,
    Emitter<AccountState> emit,
  ) async {}
}
