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
  static String updateProfile = '/mobile/profile';

  // Virtual Machine Endpoints
  static String myInstance = '/mobile/instance/instances';
  static String myLatestVM = '/mobile/dashboard/instances';
  static String getTotalResource = '/mobile/dashboard/resources';
  static String getVMDetail = '/mobile/instance/';

  //places lookup
  static String countryLookup = '/lookup/country';
  static String provinceLookup = '/lookup/province';
  static String cityLookup = '/lookup/city';
  static String districtLookup = '/lookup/district';

}
