part of 'language_bloc.dart';

abstract class LanguageEvent {}

class UpdateLanguageEvent extends LanguageEvent {
  final Locale locale;

  UpdateLanguageEvent(this.locale);
}
