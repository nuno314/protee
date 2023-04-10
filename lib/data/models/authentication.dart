import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class RequestOtpResult {
  @JsonKey(name: 'otp_string')
  String? otpString;
  @JsonKey(name: 'otp_expiry')
  DateTime? otpExpiry;

  RequestOtpResult({
    this.otpString,
    this.otpExpiry,
  });

  factory RequestOtpResult.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpResultFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpResultToJson(this);
}

@JsonSerializable()
class RequestPhoneNumberResult extends RequestOtpResult {
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  RequestPhoneNumberResult({this.phoneNumber});

  factory RequestPhoneNumberResult.fromJson(Map<String, dynamic> json) =>
      _$RequestPhoneNumberResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RequestPhoneNumberResultToJson(this);
}

@JsonSerializable()
class LoginResult {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  @JsonKey(name: 'expires_in')
  int? expireIn;

  LoginResult({
    this.accessToken,
    this.tokenType,
    this.expireIn,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

@JsonSerializable()
class ChangePasswordResult {
  @JsonKey(name: 'message')
  final String? message;

  ChangePasswordResult({
    this.message,
  });

  factory ChangePasswordResult.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResultFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResultToJson(this);
}
