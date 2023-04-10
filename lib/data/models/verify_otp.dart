enum VerifyStatus { success, sent, failed }

class VerifyOtp {
  final String? token;
  final String? code;
  final VerifyStatus status;
  final int? resendToken;
  final DateTime? otpExpiry;

  VerifyOtp(
    this.token,
    this.code,
    this.status,
    this.resendToken,
    this.otpExpiry,
  );

  Map<String, dynamic> asMap() {
    return {
      'token': token,
      'status': status,
      'resendToken': resendToken,
      'verificationId': otpExpiry?.toIso8601String(),
    };
  }
}
