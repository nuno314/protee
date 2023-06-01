// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: asOrNull(json['id']),
      name: asOrNull(json['name']),
      avatar: asOrNull(json['avatar']),
      dob: asOrNull(json['dob']),
      phoneNumber: asOrNull(json['phoneNumber']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'dob': instance.dob,
      'phoneNumber': instance.phoneNumber,
    };

UserStatistic _$UserStatisticFromJson(Map<String, dynamic> json) =>
    UserStatistic(
      members: asOrNull(json['members']),
      locations: asOrNull(json['locations']),
    );

Map<String, dynamic> _$UserStatisticToJson(UserStatistic instance) =>
    <String, dynamic>{
      'members': instance.members,
      'locations': instance.locations,
    };
