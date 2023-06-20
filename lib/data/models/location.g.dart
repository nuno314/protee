// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      type: $enumDecodeNullable(_$PositionTypeEnumMap, json['type'],
          unknownValue: PositionType.unknow),
      coordinates: asOrNull(json['coordinates']),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'type': _$PositionTypeEnumMap[instance.type],
      'coordinates': instance.coordinates,
    };

const _$PositionTypeEnumMap = {
  PositionType.point: 'Point',
  PositionType.unknow: 'unknow',
};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lng: asOrNull(json['lng']),
      lat: asOrNull(json['lat']),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lng': instance.lng,
      'lat': instance.lat,
    };

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      long: asOrNull(json['long']),
      lat: asOrNull(json['lat']),
      name: asOrNull(json['name']),
      icon: asOrNull(json['icon']),
      description: asOrNull(json['description']),
      id: asOrNull(json['id']),
      status: $enumDecodeNullable(_$UserLocationStatusEnumMap, json['status']),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: asOrNull(json['createdAt']),
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'long': instance.long,
      'lat': instance.lat,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'id': instance.id,
      'status': _$UserLocationStatusEnumMap[instance.status],
      'user': instance.user,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$UserLocationStatusEnumMap = {
  UserLocationStatus.personal: 'personal',
  UserLocationStatus.published: 'published',
};

LocationHistory _$LocationHistoryFromJson(Map<String, dynamic> json) =>
    LocationHistory(
      id: asOrNull(json['id']),
      distance: asOrNull(json['distance']),
      createdAt: asOrNull(json['createdAt']),
      locationId: asOrNull(json['locationId']),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : UserLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationHistoryToJson(LocationHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance': instance.distance,
      'createdAt': instance.createdAt?.toIso8601String(),
      'locationId': instance.locationId,
      'user': instance.user,
      'location': instance.location,
    };

ChildLastLocation _$ChildLastLocationFromJson(Map<String, dynamic> json) =>
    ChildLastLocation(
      id: asOrNull(json['id']),
      createdAt: asOrNull(json['createdAt']),
      currentLat: asOrNull(json['currentLat']),
      currentLong: asOrNull(json['currentLong']),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChildLastLocationToJson(ChildLastLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'currentLat': instance.currentLat,
      'currentLong': instance.currentLong,
      'user': instance.user,
    };
