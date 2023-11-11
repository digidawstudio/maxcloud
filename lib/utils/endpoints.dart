class Endpoints {
  // Auth Endpoints
  static String login = '/mobile/auth/login';
  static String register = '/auth/otp/request';
  static String requestOtp = '/mobile/auth/otp/request';
  static String validateOtp = '/mobile/auth/otp/verify';

  // Billing Endpoints
  static String getCurrentMonthSummary = '/mobile/billing/summary';
  static String getPaymentMethods = '/mobile/billing/v2/payment-methods';
  static String createInvoice = '/mobile/billing/v2/topup';
  static String getDepositHistory = '/mobile/billing/deposit/history';

  // Profile Endpoints
  static String getProfile = '/mobile/profile';
  static String updateProfile = '/mobile/profile';
  static String changePassword = '/mobile/profile/change-password';

  // Virtual Machine Endpoints
  static String myInstance = '/mobile/instance/instances';
  static String myLatestVM = '/mobile/dashboard/instances';
  static String getTotalResource = '/mobile/dashboard/resources';
  static String getVMDetail = '/mobile/instance/';

  // Notifications Endpoints
  static String getNotifications = '/mobile/notifications/all';
  //places lookup
  static String countryLookup = '/lookup/country';
  static String provinceLookup = '/lookup/province';
  static String cityLookup = '/lookup/city';
  static String districtLookup = '/lookup/district';


  static String helpDeskItems = '/mobile/ticket/tickets';
  static String ticketConversation = '/mobile/ticket';
  static String createTicket = '/mobile/ticket/create';
}
