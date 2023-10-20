class Endpoints {
  // Auth Endpoints
  static String login = '/mobile/auth/login';
  static String register = '/auth/otp/request';
  static String requestOtp = '/mobile/auth/otp/request';
  static String validateOtp = '/mobile/auth/otp/verify';

  // Billing Endpoints
  static String getCurrentMonthSummary = '/mobile/billing/summary';

  // Profile Endpoints
  static String getProfile = '/mobile/profile';
  static String myInstance = '/mobile/instance/instances';
}
