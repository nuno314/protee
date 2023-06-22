import 'package:json_annotation/json_annotation.dart';

import 'location.dart';
import 'user.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'user')
  User? user;
  @JsonKey(name: 'dangerousLocations')
  List<UserLocation>? dangerousLocations;
  @JsonKey(name: 'currentLocation')
  ChildLastLocation? currentLocation;

  NotificationModel({
    this.id,
    this.user,
    this.dangerousLocations,
    this.currentLocation,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
