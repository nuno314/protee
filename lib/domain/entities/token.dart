import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'token', fromJson: asOrNull)
  final String? token;
  @JsonKey(name: 'type', fromJson: asOrNull)
  final String? type;

  Token({
    this.token,
    this.type,
  });

  Token copyWith({
    String? token,
    String? type,
  }) {
    return Token(
      token: token ?? this.token,
      type: type ?? this.type,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() => 'Token(token: $token, type: $type)';

  @override
  bool operator ==(covariant Token other) {
    if (identical(this, other)) {
      return true;
    }

    return other.token == token && other.type == type;
  }

  @override
  int get hashCode => token.hashCode ^ type.hashCode;

  String get accessToken => '$type $token';

  bool get isValid => type != null && token != null;
}
