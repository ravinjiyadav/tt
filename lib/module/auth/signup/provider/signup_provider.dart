import 'package:flutter/cupertino.dart';

import '../../../../logger/app_logger.dart';
import '../../../../network/repository/auth_repository.dart';
import '../model/signup_request.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  SignupRequest request = SignupRequest();

  void signup({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required SignupRequest request,
  }) {
    authRepository
        .signup(request)
        .then((value) {
          if (value.success == true) {
            onSuccess.call(value.msg ?? "");
          } else {
            onFailure.call(value.msg ?? "");
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
