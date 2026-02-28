import 'package:book_your_truck/module/create_order/model/create_order_request.dart';

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

  Future<OrderRequestModel> getOrderList() {
    return dioHttpService
        .get(Endpoints.apiEndPoints.orderRequestsList)
        .then((value) => OrderRequestModel.fromJson(value));
  }



}
