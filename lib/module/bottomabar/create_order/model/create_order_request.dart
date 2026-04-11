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
  dynamic cargoWeight;
  String? cargoDescription;
  String? cargoMaterial;
  int? vehicleCategoryId;
  int? budget;

  CreateOrderRequest(
      {this.pickupAddress,
        this.dropoffAddress,
        this.pickupPlaceId,
        this.pickupPlaceName,
        this.dropoffPlaceId,
        this.dropoffPlaceName,
        this.pickupLat,
        this.pickupLng,
        this.dropoffLat,
        this.dropoffLng,
        this.cargoWeight,
        this.cargoDescription,
        this.cargoMaterial,
        this.vehicleCategoryId,
        this.budget});

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
    cargoWeight = json['cargo_weight'];
    cargoDescription = json['cargo_description'];
    cargoMaterial = json['cargo_material'];
    vehicleCategoryId = json['vehicle_category_id'];
    budget = json['budget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_address'] = this.pickupAddress;
    data['dropoff_address'] = this.dropoffAddress;
    data['pickup_place_id'] = this.pickupPlaceId;
    data['pickup_place_name'] = this.pickupPlaceName;
    data['dropoff_place_id'] = this.dropoffPlaceId;
    data['dropoff_place_name'] = this.dropoffPlaceName;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_lng'] = this.dropoffLng;
    data['cargo_weight'] = this.cargoWeight;
    data['cargo_description'] = this.cargoDescription;
    data['cargo_material'] = this.cargoMaterial;
    data['vehicle_category_id'] = this.vehicleCategoryId;
    data['budget'] = this.budget;
    return data;
  }
}