// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      dangerousLocations: (json['dangerousLocations'] as List<dynamic>?)
          ?.map((e) => UserLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentLocation: json['currentLocation'] == null
          ? null
          : ChildLastLocation.fromJson(
              json['currentLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'dangerousLocations': instance.dangerousLocations,
      'currentLocation': instance.currentLocation,
    };
