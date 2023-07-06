// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: asOrNull(json['id']),
      createdAt: asOrNull(json['createdAt']),
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
      title: asOrNull(json['title']),
      isRead: asOrNull(json['isRead']),
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'user': instance.user,
      'dangerousLocations': instance.dangerousLocations,
      'currentLocation': instance.currentLocation,
      'title': instance.title,
      'isRead': instance.isRead,
      'type': _$NotificationTypeEnumMap[instance.type],
    };

const _$NotificationTypeEnumMap = {
  NotificationType.addLocation: 'addLocation',
  NotificationType.joinRequest: 'joinRequest',
  NotificationType.leaveFamily: 'leaveFamily',
  NotificationType.approvedJoinFamily: 'approvedJoinFamily',
  NotificationType.removedFromFamily: 'removedFromFamily',
  NotificationType.upgradeToParent: 'upgradeToParent',
  NotificationType.downgradeToChild: 'downgradeToChild',
};
