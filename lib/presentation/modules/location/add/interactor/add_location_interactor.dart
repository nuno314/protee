import '../../../../../data/models/place_prediction.dart';
import '../repository/add_location_repository.dart';

part 'add_location_interactor.impl.dart';

abstract class AddLocationInteractor {
  Future<List<PlacePrediction>> searchPlace(String input);
}
