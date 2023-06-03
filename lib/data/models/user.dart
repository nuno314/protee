// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';

part 'user.g.dart';

enum FamilyRole {
  @JsonValue('parent')
  parent('parent');

  final String id;

  const FamilyRole(this.id);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'id', fromJson: asOrNull)
  String? id;
  @JsonKey(name: 'name', fromJson: asOrNull)
  String? name;
  @JsonKey(name: 'email', fromJson: asOrNull)
  String? email;
  @JsonKey(name: 'avt', fromJson: asOrNull)
  String? avatar;
  @JsonKey(name: 'dob', fromJson: asOrNull)
  DateTime? dob;
  @JsonKey(name: 'phoneNumber', fromJson: asOrNull)
  String? phoneNumber;
  @JsonKey(name: 'familyId', fromJson: asOrNull)
  String? familyId;
  @JsonKey(name: 'familyRole', unknownEnumValue: null)
  FamilyRole? role;
  
  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.dob,
    this.phoneNumber,
    this.familyId,
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
