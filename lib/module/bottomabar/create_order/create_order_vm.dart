import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../logger/app_logger.dart';
import '../../../network/repository/order_repository.dart';
import 'model/create_order_request.dart';
import 'model/vehicle_category_model.dart';

class CreateOrderVm extends ChangeNotifier {
  final OrderRepository orderRepository = OrderRepository();

  CreateOrderRequest request = CreateOrderRequest();



  List<Data>categories = [];

  Data? selectedCategory;
  SubCategories? selectedSubCategory;
  Variants? selectedVariant;

  /// API se data set karne ke liye
  void setData(List<Data> data) {
    categories = data;

    AppLogger.logD("Category length is ${jsonEncode(categories)}");
    notifyListeners();
  }

  void selectCategory(Data category) {
    selectedCategory = category;
    selectedSubCategory = null;
    selectedVariant = null;
    notifyListeners();
  }

  void selectSubCategory(SubCategories subCategory) {
    selectedSubCategory = subCategory;
    selectedVariant = null;
    notifyListeners();
  }

  void selectVariant(Variants variant) {
    selectedVariant = variant;
    notifyListeners();
  }



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

        setData(value.data ?? []);

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