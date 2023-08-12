
class NetworkUrls {
  static String BASE_URL = "http://itron.klystron.global:9947/";

  static String LOGIN = "web/session/authenticate";
  static String LOGOUT = "web/session/destroy";
  static String GET_ALL_SPORTS = "api/get_sports";
  static String GET_COURT = "api/get_court?activity_id=";
  static String GET_SLOT = "api/get_available_slots_for_court?court_id=";
  static String member_details = "api/get_member_details?user_id=";
  static String create_booking = "api/create_booking";
  static String booking_history = "api/get_history?user_id=";

}