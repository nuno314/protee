part of 'search_direction_bloc.dart';

abstract class SearchDirectionEvent {}

class SearchSuggestionEvent extends SearchDirectionEvent {
  final String? value;

  SearchSuggestionEvent(this.value);

}
