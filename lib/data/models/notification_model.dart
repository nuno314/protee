import 'package:json_annotation/json_annotation.dart';

import '../../common/utils.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'subject_type', fromJson: asOrNull)
  String? subjectType;
  @JsonKey(name: 'subject_id', fromJson: asOrNull)
  String? subjectId;
  @JsonKey(name: 'send_after', fromJson: asOrNull)
  DateTime? sendAfter;
  @JsonKey(name: 'read', fromJson: asOrNull)
  bool? read;

  NotificationModel({
    this.id,
    this.subjectType,
    this.sendAfter,
    this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
