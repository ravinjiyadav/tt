import 'package:flutter/cupertino.dart';

import '../../../../logger/app_logger.dart';
import '../../../network/repository/order_repository.dart';
import 'bids_model.dart';

class BidsVm extends ChangeNotifier {
  final OrderRepository orderRepository = OrderRepository();

  BidsModel bidsModel = BidsModel();

  bool isLoading = false;

  void getBidsList({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required int id,
  }) {
    isLoading = true;
    updateUi();

    orderRepository
        .getBidsList(id)
        .then((value) {
          if (value.success == true) {
            bidsModel = value;
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

  void acceptBid({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required int id,
  }) {

    orderRepository
        .acceptBid(id)
        .then((value) {
      if (value.success == true) {

        onSuccess.call(value.msg ?? "Success");
      } else {
        onSuccess.call(value.msg ?? "failed");
      }

      updateUi();
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
