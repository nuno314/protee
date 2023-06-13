class ApiContract {
  static const String socialRegiser = 'auth/user/social-register';
  static const String socialLogin = 'auth/user/social-login';
  static const String refreshToken = 'auth/user/login-by-refresh-token';
  static const String logout = 'logout';

  // Profile
  static const String profile = 'users/profile';

  // Location API
  static const String locationUser = 'location/user';
  static const String location = 'location';
  static const String locationNearby = 'location/get-nearly';
  static const String removeLocation = 'location/user-remove';

  // Family API
  static const String getFamilyProfile = 'family/profile';
  static const String getFamilyMembers = 'family/members';
  static const String getInviteCode = 'family/invite-code';
  static const String joinFamily = 'family/join';
  static const String joinFamilyRequests = 'family/join-requests';
  static const String removeMember = 'family/remove';
  static const String approveJoinRequest = 'family/approve';
  static const String leaveFamily = 'family/leave';
}
