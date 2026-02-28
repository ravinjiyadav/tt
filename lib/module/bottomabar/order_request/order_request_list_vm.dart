import 'package:flutter/cupertino.dart';
import '../../../../logger/app_logger.dart';
import '../../../network/repository/order_repository.dart';
import 'model/order_request_model.dart';

class OrderRequestListVm extends ChangeNotifier {
  final OrderRepository orderRepository = OrderRepository();

  OrderRequestModel orderRequestModel = OrderRequestModel();

  bool isLoading = false;




  void getCreatedOrderList({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure}) {

    isLoading = true;
    updateUi();


    orderRepository
        .getOrderList()
        .then((value) {
      if (value.success == true) {
        orderRequestModel = value;
        onSuccess.call("");
      } else {
        onFailure.call("");
      }

      isLoading = false;
      updateUi();
    })
        .onError((error, stackTrace) {

      isLoading = false;
      updateUi();
      AppLogger.logD("error $error");
      onFailure.call(error.toString());
    });
  }

  void updateUi() {
    notifyListeners();
  }
}
