import '../../data/models/address.dart';
import '../../data/models/location.dart';

class Place {
  final Address? address;
  final Location? location;

  Place({this.address, this.location});

  factory Place.fromAddressPrediction(Map<String, dynamic> map) {
    final street = [map['house_number'], map['street']]
        .where((element) => element != null)
        .cast<String>()
        .join(' ');
    final locationArray =
        (map['position']?['coordinates'] as List?)?.cast<double>();
    final address = Address.fromJson(map)..street = street;
    final location = locationArray?.length == 2
        ? Location(lat: locationArray![1], lng: locationArray[0])
        : null;
    return Place(
      address: address,
      location: location,
    );
  }

  Map toJson() {
    return {
      'address': address?.toJson(),
      'location': location?.toJson(),
    };
  }

  bool get isValid {
    return location != null;
  }
}
