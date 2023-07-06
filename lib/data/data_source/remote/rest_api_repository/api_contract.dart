class ApiContract {
  static const String socialRegiser = 'auth/user/social-register';
  static const String socialLogin = 'auth/user/social-login';
  static const String refreshToken = 'auth/user/login-by-refresh-token';
  static const String logout = 'logout';

  // Analysis
  static const String basicInformation = 'analytics/family/basic-information';

  // Profile
  static const String profile = 'users/profile';

  // Location API
  static const String locationUser = 'location/user';
  static const String location = 'location';
  static const String locationNearby = 'location/get-nearly';
  static const String removeLocation = 'location/user-remove';
  static const String locationHistory = 'location/user/location-history';
  static const String lastLocation = 'location/user/last-location/{userId}';

  // Family API
  static const String getFamilyProfile = 'family/profile';
  static const String getFamilyMembers = 'family/members';
  static const String getInviteCode = 'family/invite-code';
  static const String joinFamily = 'family/join';
  static const String joinFamilyRequests = 'family/join-requests';
  static const String removeMember = 'family/remove';
  static const String approveJoinRequest = 'family/approve';
  static const String rejectJoinRequest = 'family/reject';

  static const String leaveFamily = 'family/leave';
  static const String updateChild = 'family/update-child';
  static const String updateParent = 'family/update-parent';

  // Message
  static const String messages = 'message/messages';
  static const String sendMessage = 'message';

  // Notification
  static const String notification = 'notifications';
  static const String readNotification = 'notifications/read/{id}';

  static const String readAllNotification = 'notifications/mark-all-as-read';
}
