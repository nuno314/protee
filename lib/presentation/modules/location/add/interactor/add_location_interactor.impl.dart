part of 'add_location_interactor.dart';

class AddLocationInteractorImpl extends AddLocationInteractor {
  final AddLocationRepository _repository;

  AddLocationInteractorImpl(this._repository);

  @override
  Future<List<PlacePrediction>> searchPlace(String input) {
    return _repository.searchPlaces(input);
  }
}
