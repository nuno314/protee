import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';
import 'user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'id', fromJson: asOrNull)
  String? id;
  @JsonKey(name: 'content', fromJson: asOrNull)
  String? content;
  @JsonKey(name: 'createdAt', fromJson: asOrNull)
  DateTime? createdAt;
  @JsonKey(name: 'user')
  User? user;
  Message({
    this.id,
    this.content,
    this.createdAt,
    this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
