class ApiContract {
  static const String socialRegiser = 'auth/user/social-register';
  static const String socialLogin = 'auth/user/social-login';
  static const String refreshToken = 'auth/user/login-by-refresh-token';
  static const String logout = 'logout';

  // Profile
  static const String profile = 'system-user/profile';

  // Location API
  static const String location = 'location';

  // Family API
  static const String getFamilyProfile = 'family/profile';
  static const String getFamilyMembers = 'family/members';
  static const String getInviteCode = 'family/invite-code';
  static const String joinFamily = 'family/join';
  static const String approveJoinFamily = 'family/approve';
  static const String leaveFamily = 'family/leave';
}
