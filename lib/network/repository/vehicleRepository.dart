// import 'package:dio/dio.dart';
// import 'package:truck_transporter/module/bottomabar/dashboard/dashboard/model/vehhicle_model.dart';
// import 'package:truck_transporter/network/model/response/basic_response.dart';
//
// import '../client/dio_http_service.dart';
// import '../end_points.dart';
//
// class VehicleRepository {
//   DioHttpService dioHttpService = DioHttpService();
//
//   Future<BasicResponse> createVehicle(FormData request) {
//     return dioHttpService
//         .post(
//           Endpoints.apiEndPoints.createVehicle,
//           // data: FormData.fromMap(request))
//           data: request,
//         )
//         .then((value) => BasicResponse.fromJson(value));
//   }
//
//   Future<VehicleModel> getVehicle() {
//     return dioHttpService
//         .get(Endpoints.apiEndPoints.createVehicle)
//         .then((value) => VehicleModel.fromJson(value));
//   }
// }
