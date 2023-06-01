import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id', fromJson: asOrNull)
  String? id;
  @JsonKey(name: 'name', fromJson: asOrNull)
  String? name;
  @JsonKey(name: 'avatar', fromJson: asOrNull)
  String? avatar;
  @JsonKey(name: 'dob', fromJson: asOrNull)
  String? dob;
    @JsonKey(name: 'phoneNumber', fromJson: asOrNull)
  String? phoneNumber;
  User({
    this.id,
    this.name,
    this.avatar,
    this.dob,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserStatistic {
  @JsonKey(name: 'members', fromJson: asOrNull)
  int? members;
  @JsonKey(name: 'locations', fromJson: asOrNull)
  int? locations;
  UserStatistic({
    this.members,
    this.locations,
  });

  factory UserStatistic.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatisticToJson(this);
}
