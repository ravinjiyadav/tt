import 'package:flutter/cupertino.dart';
import '../../../logger/app_logger.dart';
import '../../../network/repository/auth_repository.dart';
import 'model/login_request.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();


  void logIn({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required LoginRequest request,
  }) {
    authRepository
        .login(request)
        .then((value) {
      if (value.success == true) {



        onSuccess.call(value.msg ?? "");
      } else {
        onFailure.call(value.msg ?? "");
      }
    })
        .onError((error, stackTrace) {
      AppLogger.logD("error ${error.toString()}");
      onFailure.call(error.toString());
    });
  }

  void updateUi() {
    notifyListeners();
  }
}
