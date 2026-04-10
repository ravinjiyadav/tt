import 'package:book_your_truck/module/bottomabar/order_bids/bids_model.dart';

import '../../module/bottomabar/create_order/model/VahicleCategoryModel.dart';
import '../../module/bottomabar/create_order/model/create_order_request.dart';
import '../../module/bottomabar/order_request/model/order_request_model.dart';
import '../client/dio_http_service.dart';
import '../end_points.dart';
import '../model/response/basic_response.dart';

class OrderRepository {
  DioHttpService dioHttpService = DioHttpService();

  Future<BasicResponse> createOrder(CreateOrderRequest request) {
    return dioHttpService
        .post(Endpoints.apiEndPoints.orderRequests, data: request.toJson())
        .then((value) => BasicResponse.fromJson(value));
  }


  Future<VehicleCategory> vehicleCategories(var request) {
    return dioHttpService
        .get(Endpoints.apiEndPoints.vehicleCategories,)
        .then((value) => VehicleCategory.fromJson(value));
  }


  Future<OrderRequestModel> getOrderList() {
    return dioHttpService
        .get(Endpoints.apiEndPoints.orderRequestsList)
        .then((value) => OrderRequestModel.fromJson(value));
  }

  Future<BidsModel> getBidsList(int id) {
    return dioHttpService
        .get(Endpoints.apiEndPoints.bidList(id))
        .then((value) => BidsModel.fromJson(value));
  }


  Future<BasicResponse> acceptBid(int id) {
    return dioHttpService
        .post(Endpoints.apiEndPoints.acceptBid(id))
        .then((value) => BasicResponse.fromJson(value));
  }



}
