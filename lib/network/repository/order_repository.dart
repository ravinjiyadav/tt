import 'package:book_your_truck/module/create_order/model/create_order_request.dart';

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
}
