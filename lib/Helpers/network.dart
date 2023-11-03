class NetworkUrls {
  static String DB = "INDIACLUB";

  // static String DB = "indiaclub1";

  // static String BASE_URL = "http://itron.klystron.global:9947/";
  static String BASE_URL = "https://members.indiaclubdubai.com/";

  static String LOGIN = "web/session/authenticate";
  static String LOGOUT = "web/session/destroy";
  static String GET_ALL_SPORTS = "api/get_sports";
  static String GET_COURT = "api/get_court?activity_id=";
  static String GET_SLOT = "api/get_available_slots_for_court?court_id=";
  static String member_details = "api/get_member_details?user_id=";
  static String create_booking = "api/create_booking";
  static String booking_history = "api/get_history?user_id=";
  static String profile = "web/image?model=res.users&id=";
  static String banner_images = "api/get_banner_images?user_id=";
  static String reset_password = "api/reset_password";
  static String cancel_booking = "api/booking_cancel";

}
