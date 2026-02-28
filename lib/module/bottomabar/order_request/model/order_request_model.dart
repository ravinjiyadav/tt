class OrderRequestModel {
  bool? success;
  List<Order>? order;

  OrderRequestModel({this.success, this.order});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      order = <Order>[];
      json['data'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.order != null) {
      data['data'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? customerId;
  String? pickupCity;
  String? dropoffCity;
  String? pickupAddress;
  String? dropoffAddress;
  double? pickupLat;
  double? pickupLng;
  double? dropoffLat;
  double? dropoffLng;
  dynamic? cargoWeight;
  String? cargoDescription;
  String? preferredVehicleType;
  String? pickupDate;
  String? pickupTimePreference;
  String? specialRequirements;
  dynamic? budgetRangeMin;
  dynamic? budgetRangeMax;
  String? status;
  String? expiresAt;
  int? selectedBidId;
  int? bidCount;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  Order(
      {this.id,
        this.customerId,
        this.pickupCity,
        this.dropoffCity,
        this.pickupAddress,
        this.dropoffAddress,
        this.pickupLat,
        this.pickupLng,
        this.dropoffLat,
        this.dropoffLng,
        this.cargoWeight,
        this.cargoDescription,
        this.preferredVehicleType,
        this.pickupDate,
        this.pickupTimePreference,
        this.specialRequirements,
        this.budgetRangeMin,
        this.budgetRangeMax,
        this.status,
        this.expiresAt,
        this.selectedBidId,
        this.bidCount,
        this.createdAt,
        this.updatedAt,
        this.customer});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    pickupCity = json['pickup_city'];
    dropoffCity = json['dropoff_city'];
    pickupAddress = json['pickup_address'];
    dropoffAddress = json['dropoff_address'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropoffLat = json['dropoff_lat'];
    dropoffLng = json['dropoff_lng'];
    cargoWeight = json['cargo_weight'];
    cargoDescription = json['cargo_description'];
    preferredVehicleType = json['preferred_vehicle_type'];
    pickupDate = json['pickup_date'];
    pickupTimePreference = json['pickup_time_preference'];
    specialRequirements = json['special_requirements'];
    budgetRangeMin = json['budget_range_min'];
    budgetRangeMax = json['budget_range_max'];
    status = json['status'];
    expiresAt = json['expires_at'];
    selectedBidId = json['selected_bid_id'];
    bidCount = json['bid_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['pickup_city'] = this.pickupCity;
    data['dropoff_city'] = this.dropoffCity;
    data['pickup_address'] = this.pickupAddress;
    data['dropoff_address'] = this.dropoffAddress;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_lng'] = this.dropoffLng;
    data['cargo_weight'] = this.cargoWeight;
    data['cargo_description'] = this.cargoDescription;
    data['preferred_vehicle_type'] = this.preferredVehicleType;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time_preference'] = this.pickupTimePreference;
    data['special_requirements'] = this.specialRequirements;
    data['budget_range_min'] = this.budgetRangeMin;
    data['budget_range_max'] = this.budgetRangeMax;
    data['status'] = this.status;
    data['expires_at'] = this.expiresAt;
    data['selected_bid_id'] = this.selectedBidId;
    data['bid_count'] = this.bidCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
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
