part of 'search_direction_screen.dart';

extension SearchDirectionAction on _SearchDirectionScreenState {
  void _blocListener(BuildContext context, SearchDirectionState state) {}

  void search(String? value) {
    bloc.add(SearchSuggestionEvent(value ?? ''));
  }

  void _onTapPrediction(PlacePrediction prediction) {
    Navigator.pop(context, prediction.placeId);
  }

  void _onTapPlace(GoogleMapPlace place) {
    Navigator.pop(context, place.placeId);
  }
}
