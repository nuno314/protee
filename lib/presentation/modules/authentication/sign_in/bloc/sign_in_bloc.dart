import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/sign_in_interactor.dart';
import '../repository/sign_in_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends AppBlocBase<SignInEvent, SignInState> {
  late final _interactor = SignInInteractorImpl(
    SignInRepositoryImpl(),
  );
  
  SignInBloc() : super(SignInInitial(viewModel: const _ViewModel())) {
    on<SignInEvent>(_onSignInEvent);
  }

  Future<void> _onSignInEvent(
    SignInEvent event,
    Emitter<SignInState> emit,
  ) async {}
}