import 'package:flutter/cupertino.dart';

import '../../../../logger/app_logger.dart';
import '../../../network/repository/order_repository.dart';
import 'model/create_order_request.dart';
import 'model/vehicle_category_model.dart';

class CreateOrderVm extends ChangeNotifier {
  final OrderRepository orderRepository = OrderRepository();

  CreateOrderRequest request = CreateOrderRequest();


  List<Vehiclecategory> vehicleCategory = [];

  void createRide({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
    required CreateOrderRequest request,
  }) {
    orderRepository
        .createOrder(request)
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


  void fetchVehicleCategory({
    required ValueChanged<String> onSuccess,
    required ValueChanged<String> onFailure,
  }) {
    orderRepository
        .vehicleCategories(request)
        .then((value) {
      if (value.success == true) {

        vehicleCategory = value.data ?? [];

        updateUi();

        onSuccess.call("Success");
      } else {

        onFailure.call("Error");
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