class OrderRequestModel {
  bool? success;
  List<Data>? data;

  OrderRequestModel({this.success, this.data});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  dynamic? totalExpectedAmount;
  dynamic? advanceAmount;
  dynamic? remainingAmount;
  int? id;
  int? customerId;
  String? pickupAddress;
  String? dropoffAddress;
  String? pickupPlaceId;
  String? pickupPlaceName;
  double? pickupLat;
  double? pickupLng;
  String? dropoffPlaceId;
  String? dropoffPlaceName;
  double? dropoffLat;
  double? dropoffLng;
  String? cargoDescription;
  String? cargoMaterial;
  int? vehicleCategoryId;
  String? status;
  String? expiresAt;
  dynamic? selectedBidId;
  int? bidCount;
  dynamic? expectedPrice;
  dynamic? expectedPriceType;
  dynamic? estimatedWeightTons;
  String? paymentMethod;
  dynamic? advancePaymentPercentage;
  String? createdAt;
  String? updatedAt;
  VehicleCategory? vehicleCategory;
  Customer? customer;

  Data(
      {this.totalExpectedAmount,
      this.advanceAmount,
      this.remainingAmount,
      this.id,
      this.customerId,
      this.pickupAddress,
      this.dropoffAddress,
      this.pickupPlaceId,
      this.pickupPlaceName,
      this.pickupLat,
      this.pickupLng,
      this.dropoffPlaceId,
      this.dropoffPlaceName,
      this.dropoffLat,
      this.dropoffLng,
      this.cargoDescription,
      this.cargoMaterial,
      this.vehicleCategoryId,
      this.status,
      this.expiresAt,
      this.selectedBidId,
      this.bidCount,
      this.expectedPrice,
      this.expectedPriceType,
      this.estimatedWeightTons,
      this.paymentMethod,
      this.advancePaymentPercentage,
      this.createdAt,
      this.updatedAt,
      this.vehicleCategory,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    totalExpectedAmount = json['total_expected_amount'];
    advanceAmount = json['advance_amount'];
    remainingAmount = json['remaining_amount'];
    id = json['id'];
    customerId = json['customer_id'];
    pickupAddress = json['pickup_address'];
    dropoffAddress = json['dropoff_address'];
    pickupPlaceId = json['pickup_place_id'];
    pickupPlaceName = json['pickup_place_name'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropoffPlaceId = json['dropoff_place_id'];
    dropoffPlaceName = json['dropoff_place_name'];
    dropoffLat = json['dropoff_lat'];
    dropoffLng = json['dropoff_lng'];
    cargoDescription = json['cargo_description'];
    cargoMaterial = json['cargo_material'];
    vehicleCategoryId = json['vehicle_category_id'];
    status = json['status'];
    expiresAt = json['expires_at'];
    selectedBidId = json['selected_bid_id'];
    bidCount = json['bid_count'];
    expectedPrice = json['expected_price'];
    expectedPriceType = json['expected_price_type'];
    estimatedWeightTons = json['estimated_weight_tons'];
    paymentMethod = json['payment_method'];
    advancePaymentPercentage = json['advance_payment_percentage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    vehicleCategory = json['vehicleCategory'] != null
        ? new VehicleCategory.fromJson(json['vehicleCategory'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_expected_amount'] = this.totalExpectedAmount;
    data['advance_amount'] = this.advanceAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['pickup_address'] = this.pickupAddress;
    data['dropoff_address'] = this.dropoffAddress;
    data['pickup_place_id'] = this.pickupPlaceId;
    data['pickup_place_name'] = this.pickupPlaceName;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['dropoff_place_id'] = this.dropoffPlaceId;
    data['dropoff_place_name'] = this.dropoffPlaceName;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_lng'] = this.dropoffLng;
    data['cargo_description'] = this.cargoDescription;
    data['cargo_material'] = this.cargoMaterial;
    data['vehicle_category_id'] = this.vehicleCategoryId;
  
    data['status'] = this.status;
    data['expires_at'] = this.expiresAt;
    data['selected_bid_id'] = this.selectedBidId;
    data['bid_count'] = this.bidCount;
    data['expected_price'] = this.expectedPrice;
    data['expected_price_type'] = this.expectedPriceType;
    data['estimated_weight_tons'] = this.estimatedWeightTons;
    data['payment_method'] = this.paymentMethod;
    data['advance_payment_percentage'] = this.advancePaymentPercentage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.vehicleCategory != null) {
      data['vehicleCategory'] = this.vehicleCategory!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class VehicleCategory {
  int? id;
  String? bodyType;
  String? wheels;
  dynamic? weight;
  int? length;

  VehicleCategory(
      {this.id, this.bodyType, this.wheels, this.weight, this.length});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bodyType = json['body_type'];
    wheels = json['wheels'];
    weight = json['weight'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body_type'] = this.bodyType;
    data['wheels'] = this.wheels;
    data['weight'] = this.weight;
    data['length'] = this.length;
    return data;
  }
}

class Customer {
  int? id;
  String? firstname;
  String? lastname;

  Customer({this.id, this.firstname, this.lastname});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
