import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../interactor/sign_in_interactor.dart';
import '../repository/sign_in_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends AppBlocBase<SignInEvent, SignInState> {
  late final _interactor = SignInInteractorImpl(
    SignInRepositoryImpl(),
  );

  final _googleSignIn = injector.get<GoogleSignIn>();

  SignInBloc() : super(SignInInitial(viewModel: const _ViewModel())) {
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<FacebookSignInEvent>(_onFacebookSignInEvent);
  }

  Future<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    final auth = FirebaseAuth.instance;
    User? user;
    await _googleSignIn.signOut();
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      emit(state.copyWith<LoginFailed>());
      return;
    }

    final authentication = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    try {
      final userCredential = await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // ...
      } else if (e.code == 'invalid-credential') {
        // ...
      }
    } catch (e) {
      // ...
    }
    final token = await user?.getIdToken() ?? '';
    final res = await _interactor.logInByGoogle(
      token,
    );
    emit(
      state.copyWith<LoginSuccess>().copyWith(
            viewModel: state.viewModel.copyWith(
              token: token,
            ),
          ),
    );
  }

  FutureOr<void> _onFacebookSignInEvent(
    FacebookSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    final loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    if (loginResult.accessToken?.token == null) {
      return;
    }
    final facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    final res = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    if (res.credential?.accessToken == null) {
      emit(state.copyWith<LoginFailed>());
      return;
    }

    await _interactor.logInByFacebook(res.credential!.accessToken!);
    emit(
      state.copyWith<LoginSuccess>(),
    );
  }
}
