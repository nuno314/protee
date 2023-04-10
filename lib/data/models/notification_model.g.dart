// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      subjectType: asOrNull(json['subject_type']),
      sendAfter: asOrNull(json['send_after']),
      read: asOrNull(json['read']),
    )..subjectId = asOrNull(json['subject_id']);

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_type': instance.subjectType,
      'subject_id': instance.subjectId,
      'send_after': instance.sendAfter?.toIso8601String(),
      'read': instance.read,
    };
