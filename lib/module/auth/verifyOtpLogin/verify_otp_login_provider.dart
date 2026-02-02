import 'package:flutter/cupertino.dart';

import '../../../logger/app_logger.dart';
import '../../../network/repository/auth_repository.dart';
import '../../../utilities/shared_preference.dart';
import 'model/login_verify_otp_model.dart';

class VerifyOtpLoginProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  void verifyOtp({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required String otp,
    required String phone,
  }) {
    Map request = {"phone": phone, "otp": otp};
    authRepository
        .verifyLoginOtp(request)
        .then((value) {
          if (value.success == true) {
            LoginVerifyOtpModel loginVerifyOtpModel = value;

            Preference.setAccessToken(value.token ?? "");
            Preference.setUserName(value.data?.name ?? "");
            Preference.setTransporterName(value.data?.transportName ?? "");
            Preference.setPhoneNumber(value.data?.phone ?? "");
            Preference.setId(value.data?.vendorId ?? 0);

            Preference.setUserLogin(true);
            onSuccess.call(value.message ?? "");
          } else {
            onFailure.call(value.message ?? "");
          }
        })
        .onError((error, stackTrace) {
          AppLogger.logD("error $error");
          onFailure.call(error.toString());
        });
  }

  void updateUi() {
    notifyListeners();
  }
}
