// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: asOrNull(json['name']),
      avatar: asOrNull(json['avatar']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
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
