// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';
import '../../common/utils/extensions.dart';
import 'location.dart';
import 'user.dart';

part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('addLocation')
  addLocation('addLocation'),
  @JsonValue('joinRequest')
  joinRequest('joinRequest'),
  @JsonValue('leaveFamily')
  leaveFamily('leaveFamily'),
  @JsonValue('approvedJoinFamily')
  approvedJoinFamily('approvedJoinFamily'),
  @JsonValue('removedFromFamily')
  removedFromFamily('removedFromFamily'),
  @JsonValue('upgradeToParent')
  upgradeToParent('upgradeToParent'),
  @JsonValue('downgradeToChild')
  downgradeToChild('downgradeToChild');

  final String id;

  const NotificationType(this.id);
}

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'id', fromJson: asOrNull)
  String? id;
  @JsonKey(name: 'createdAt', fromJson: asOrNull)
  DateTime? createdAt;
  @JsonKey(name: 'user')
  User? user;
  @JsonKey(name: 'dangerousLocations')
  List<UserLocation>? dangerousLocations;
  @JsonKey(name: 'currentLocation')
  ChildLastLocation? currentLocation;
  @JsonKey(name: 'title', fromJson: asOrNull)
  String? title;
  @JsonKey(name: 'isRead', fromJson: asOrNull)
  bool? isRead;
  @JsonKey(name: 'type', unknownEnumValue: null)
  final NotificationType? type;

  NotificationModel({
    this.id,
    this.createdAt,
    this.user,
    this.dangerousLocations,
    this.currentLocation,
    this.title,
    this.isRead,
    this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  String get name =>
      dangerousLocations
          ?.where((element) => element.name.isNotNullOrEmpty)
          .map((e) => e.name!)
          .join(', ') ??
      '--';

  double? get distance => dangerousLocations?.firstOrNull?.distance;
}
