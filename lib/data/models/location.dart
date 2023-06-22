// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';
import 'user.dart';

part 'location.g.dart';

enum PositionType {
  @JsonValue('Point')
  point,
  unknow,
}

@JsonSerializable()
class Position {
  @JsonKey(name: 'type', unknownEnumValue: PositionType.unknow)
  PositionType? type;
  @JsonKey(name: 'coordinates', fromJson: asOrNull)
  List<double>? coordinates;

  Position({this.type, this.coordinates});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  Location? get location {
    try {
      switch (type) {
        case PositionType.point:
          return Location(
            lng: coordinates?[0],
            lat: coordinates?[1],
          );
        default:
      }
    } catch (_) {}
    return null;
  }
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'lng', fromJson: asOrNull)
  final double? lng;
  @JsonKey(name: 'lat', fromJson: asOrNull)
  final double? lat;

  Location({
    this.lng,
    this.lat,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  bool get isValid => lat != null && lng != null;

  /// Return metter distance
  double? distanceFrom(Location? other) {
    if (!isValid || !(other?.isValid == true)) {
      return null;
    }
    return Geolocator.distanceBetween(
      lat!,
      lng!,
      other!.lat!,
      other.lng!,
    );
  }

  factory Location.from({required LatLng latLng}) {
    return Location(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
  }

  String get encode {
    return Uri.encodeComponent('$lat,$lng');
  }
}

@JsonSerializable()
class UserLocation {
  @JsonKey(name: 'long', fromJson: asOrNull)
  final double? long;
  @JsonKey(name: 'lat', fromJson: asOrNull)
  final double? lat;
  @JsonKey(name: 'name', fromJson: asOrNull)
  final String? name;
  @JsonKey(name: 'icon', fromJson: asOrNull)
  final String? icon;
  @JsonKey(name: 'description', fromJson: asOrNull)
  final String? description;
  @JsonKey(name: 'id', fromJson: asOrNull)
  final String? id;
  @JsonKey(name: 'status', unknownEnumValue: null)
  final UserLocationStatus? status;
  @JsonKey(name: 'user')
  final User? user;
  @JsonKey(name: 'createdAt', fromJson: asOrNull)
  final DateTime? createdAt;
  @JsonKey(name: 'distance', fromJson: asOrNull)
  final double? distance;

  UserLocation({
    this.long,
    this.lat,
    this.name,
    this.icon,
    this.description,
    this.id,
    this.status,
    this.user,
    this.createdAt,
    this.distance,
  });

  double? distanceFrom(Location? other) {
    if (!isValid || !(other?.isValid == true)) {
      return null;
    }
    return Geolocator.distanceBetween(
      lat!,
      long!,
      other!.lat!,
      other.lng!,
    );
  }

  bool get isValid => lat != null && long != null;

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}

enum UserLocationStatus {
  @JsonValue('personal')
  personal('personal'),
  @JsonValue('published')
  published('published');

  final String id;

  const UserLocationStatus(this.id);
}

@JsonSerializable()
class LocationHistory {
  @JsonKey(name: 'id', fromJson: asOrNull)
  final String? id;
  @JsonKey(name: 'distance', fromJson: asOrNull)
  final int? distance;
  @JsonKey(name: 'createdAt', fromJson: asOrNull)
  final DateTime? createdAt;
  @JsonKey(name: 'locationId', fromJson: asOrNull)
  final String? locationId;
  @JsonKey(name: 'user')
  final User? user;
  @JsonKey(name: 'location')
  final UserLocation? location;
  LocationHistory({
    this.id,
    this.distance,
    this.createdAt,
    this.locationId,
    this.user,
    this.location,
  });

  factory LocationHistory.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$LocationHistoryToJson(this);
}

@JsonSerializable()
class ChildLastLocation {
  @JsonKey(name: 'id', fromJson: asOrNull)
  final String? id;
  @JsonKey(name: 'createdAt', fromJson: asOrNull)
  final DateTime? createdAt;
  @JsonKey(name: 'currentLat', fromJson: asOrNull)
  final String? currentLat;
  @JsonKey(name: 'currentLong', fromJson: asOrNull)
  final String? currentLong;
  @JsonKey(name: 'user')
  final User? user;

  ChildLastLocation({
    this.id,
    this.createdAt,
    this.currentLat,
    this.currentLong,
    this.user,
  });

  factory ChildLastLocation.fromJson(Map<String, dynamic> json) =>
      _$ChildLastLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ChildLastLocationToJson(this);
}
