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
    };

const _$UserLocationStatusEnumMap = {
  UserLocationStatus.personal: 'personal',
  UserLocationStatus.published: 'published',
};
