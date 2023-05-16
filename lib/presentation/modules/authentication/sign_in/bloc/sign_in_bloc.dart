import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  }

  Future<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    final auth = FirebaseAuth.instance;
    User? user;

    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final authentication = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      try {
        final userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
        var token = await user?.getIdToken() ?? '';
        while (token.isNotEmpty) {
          final initLength = token.length >= 500 ? 500 : token.length;
          print(token.substring(0, initLength));
          final endLength = token.length;
          token = token.substring(initLength, endLength);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ...
      }
    }
    emit(state.copyWith<LoginSuccess>());
  }
}
