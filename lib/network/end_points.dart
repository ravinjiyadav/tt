class Endpoints {
  const Endpoints._();

  static const baseUrl = "http://72.60.202.97/api/";
  static ApiEndPoints apiEndPoints = ApiEndPoints();

  static const imageBaseUrl = "http://72.60.202.97/api/";

}


class ApiEndPoints {


  String get login => "customers/login";
  String get verifyOtp => "customers/verify-otp";
  String get signup => "customers/register";
  String get fetchProfile => "vendors/";
  String get orderRequests => "order-requests";
  String get orderRequestsList => "order-requests";


 // String get bidList(int id) => "/order-requests/${id}/bids";


  String bidList(int id) => "/order-requests/$id/bids";



}
