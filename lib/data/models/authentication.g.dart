// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOtpResult _$RequestOtpResultFromJson(Map<String, dynamic> json) =>
    RequestOtpResult(
      otpString: json['otp_string'] as String?,
      otpExpiry: json['otp_expiry'] == null
          ? null
          : DateTime.parse(json['otp_expiry'] as String),
    );

Map<String, dynamic> _$RequestOtpResultToJson(RequestOtpResult instance) =>
    <String, dynamic>{
      'otp_string': instance.otpString,
      'otp_expiry': instance.otpExpiry?.toIso8601String(),
    };

RequestPhoneNumberResult _$RequestPhoneNumberResultFromJson(
        Map<String, dynamic> json) =>
    RequestPhoneNumberResult(
      phoneNumber: json['phone_number'] as String?,
    )
      ..otpString = json['otp_string'] as String?
      ..otpExpiry = json['otp_expiry'] == null
          ? null
          : DateTime.parse(json['otp_expiry'] as String);

Map<String, dynamic> _$RequestPhoneNumberResultToJson(
        RequestPhoneNumberResult instance) =>
    <String, dynamic>{
      'otp_string': instance.otpString,
      'otp_expiry': instance.otpExpiry?.toIso8601String(),
      'phone_number': instance.phoneNumber,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expireIn: json['expires_in'] as int?,
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expireIn,
    };

ChangePasswordResult _$ChangePasswordResultFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResult(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResultToJson(
        ChangePasswordResult instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
