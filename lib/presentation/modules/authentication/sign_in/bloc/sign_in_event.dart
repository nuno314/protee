// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class GoogleSignInEvent extends SignInEvent {}

class FacebookSignInEvent extends SignInEvent {}