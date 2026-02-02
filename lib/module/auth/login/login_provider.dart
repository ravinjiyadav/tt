import 'package:flutter/cupertino.dart';
import '../../../network/repository/auth_repository.dart';
import 'model/login_request.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  get AppLogger => null;

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
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
  }

  void updateUi() {
    notifyListeners();
  }
}
