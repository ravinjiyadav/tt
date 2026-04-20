class CreateOrderRequest {
  String? pickupAddress;
  String? dropoffAddress;
  String? pickupPlaceId;
  String? pickupPlaceName;
  String? dropoffPlaceId;
  String? dropoffPlaceName;
  double? pickupLat;
  double? pickupLng;
  double? dropoffLat;
  double? dropoffLng;
  String? cargoDescription;
  String? cargoMaterial;
  int? vehicleCategoryId;
  int? budget;
  dynamic expectedPrice;
  String? expectedPriceType;
  dynamic estimatedWeightTons;
  String? paymentMethod;
  dynamic advancePaymentPercentage;

  CreateOrderRequest({
    this.pickupAddress,
    this.dropoffAddress,
    this.pickupPlaceId,
    this.pickupPlaceName,
    this.dropoffPlaceId,
    this.dropoffPlaceName,
    this.pickupLat,
    this.pickupLng,
    this.dropoffLat,
    this.dropoffLng,
    this.cargoDescription,
    this.cargoMaterial,
    this.vehicleCategoryId,
    this.budget,
    this.expectedPrice,
    this.expectedPriceType,
    this.estimatedWeightTons,
    this.paymentMethod,
    this.advancePaymentPercentage,
  });

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    pickupAddress = json['pickup_address'];
    dropoffAddress = json['dropoff_address'];
    pickupPlaceId = json['pickup_place_id'];
    pickupPlaceName = json['pickup_place_name'];
    dropoffPlaceId = json['dropoff_place_id'];
    dropoffPlaceName = json['dropoff_place_name'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropoffLat = json['dropoff_lat'];
    dropoffLng = json['dropoff_lng'];
    cargoDescription = json['cargo_description'];
    cargoMaterial = json['cargo_material'];
    vehicleCategoryId = json['vehicle_category_id'];
    budget = json['budget'];
    expectedPrice = json['expected_price'];
    expectedPriceType = json['expected_price_type'];
    estimatedWeightTons = json['estimated_weight_tons'];
    paymentMethod = json['payment_method'];
    advancePaymentPercentage = json['advance_payment_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pickup_address'] = pickupAddress;
    data['dropoff_address'] = dropoffAddress;
    data['pickup_place_id'] = pickupPlaceId;
    data['pickup_place_name'] = pickupPlaceName;
    data['dropoff_place_id'] = dropoffPlaceId;
    data['dropoff_place_name'] = dropoffPlaceName;
    data['pickup_lat'] = pickupLat;
    data['pickup_lng'] = pickupLng;
    data['dropoff_lat'] = dropoffLat;
    data['dropoff_lng'] = dropoffLng;
    data['cargo_description'] = cargoDescription;
    data['cargo_material'] = cargoMaterial;
    data['vehicle_category_id'] = vehicleCategoryId;
    data['budget'] = budget;
    data['expected_price'] = expectedPrice;
    data['expected_price_type'] = expectedPriceType;
    data['estimated_weight_tons'] = estimatedWeightTons;
    data['payment_method'] = paymentMethod;
    data['advance_payment_percentage'] = advancePaymentPercentage;
    return data;
  }
}
