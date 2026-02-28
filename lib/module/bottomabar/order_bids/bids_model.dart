class BidsModel {
  bool? success;
  List<BidsData>? data;

  BidsModel({this.success, this.data});

  BidsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BidsData>[];
      json['data'].forEach((v) {
        data!.add(new BidsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BidsData {
  int? id;
  int? orderRequestId;
  int? vehicleId;
  dynamic? quotedPrice;
  dynamic? estimatedTimeMin;
  String? pickupTimeOffered;
  String? bidDetails;
  String? status;
  String? validUntil;
  String? vehicleDisplayInfo;
  String? selectedAt;
  String? createdAt;
  String? updatedAt;
  OrderRequest? orderRequest;

  BidsData(
      {this.id,
        this.orderRequestId,
        this.vehicleId,
        this.quotedPrice,
        this.estimatedTimeMin,
        this.pickupTimeOffered,
        this.bidDetails,
        this.status,
        this.validUntil,
        this.vehicleDisplayInfo,
        this.selectedAt,
        this.createdAt,
        this.updatedAt,
        this.orderRequest});

  BidsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRequestId = json['order_request_id'];
    vehicleId = json['vehicle_id'];
    quotedPrice = json['quoted_price'];
    estimatedTimeMin = json['estimated_time_min'];
    pickupTimeOffered = json['pickup_time_offered'];
    bidDetails = json['bid_details'];
    status = json['status'];
    validUntil = json['valid_until'];
    vehicleDisplayInfo = json['vehicle_display_info'];
    selectedAt = json['selected_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderRequest = json['orderRequest'] != null
        ? new OrderRequest.fromJson(json['orderRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_request_id'] = this.orderRequestId;
    data['vehicle_id'] = this.vehicleId;
    data['quoted_price'] = this.quotedPrice;
    data['estimated_time_min'] = this.estimatedTimeMin;
    data['pickup_time_offered'] = this.pickupTimeOffered;
    data['bid_details'] = this.bidDetails;
    data['status'] = this.status;
    data['valid_until'] = this.validUntil;
    data['vehicle_display_info'] = this.vehicleDisplayInfo;
    data['selected_at'] = this.selectedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.orderRequest != null) {
      data['orderRequest'] = this.orderRequest!.toJson();
    }
    return data;
  }
}

class OrderRequest {
  int? id;
  String? pickupCity;
  String? dropoffCity;

  OrderRequest({this.id, this.pickupCity, this.dropoffCity});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupCity = json['pickup_city'];
    dropoffCity = json['dropoff_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_city'] = this.pickupCity;
    data['dropoff_city'] = this.dropoffCity;
    return data;
  }
}
