
import '../../module/auth/login/model/login_request.dart';
import '../../module/auth/signup/model/signup_request.dart';
import '../../module/auth/verifyOtpLogin/model/login_verify_otp_model.dart';
import '../../utilities/shared_preference.dart';
import '../client/dio_http_service.dart';
import '../end_points.dart';
import '../model/response/auth/login/login_response.dart';
import '../model/response/basic_response.dart';

class AuthRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<LoginResponse> login(LoginRequest request) {
    return dioHttpService
        .post(Endpoints.apiEndPoints.login, data: request.toJson())
        .then((value) => LoginResponse.fromJson(value));
  }

  Future<LoginVerifyOtpModel> verifyLoginOtp(Map request) {
    return dioHttpService
        .post(Endpoints.apiEndPoints.verifyOtp, data: request)
        .then((value) => LoginVerifyOtpModel.fromJson(value));
  }

  Future<BasicResponse> signup(SignupRequest request) {
    return dioHttpService
        .post(Endpoints.apiEndPoints.signup, data: request.toJson())
        .then((value) => BasicResponse.fromJson(value));
  }

  Future<LoginVerifyOtpModel> fetchProfile() {
    return dioHttpService
        .get("${Endpoints.apiEndPoints.fetchProfile}${Preference.getId()}")
        .then((value) => LoginVerifyOtpModel.fromJson(value));
  }

  Future<LoginVerifyOtpModel> updateProfile(Map request) {
    return dioHttpService
        .put("${Endpoints.apiEndPoints.fetchProfile}${Preference.getId()}",data: request)
        .then((value) => LoginVerifyOtpModel.fromJson(value));
  }



}
