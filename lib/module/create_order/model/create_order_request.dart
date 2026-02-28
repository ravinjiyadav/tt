class CreateOrderRequest {
  String? pickupCity;
  String? dropoffCity;
  String? pickupAddress;
  String? dropoffAddress;
  double? pickupLat;
  double? pickupLng;
  double? dropoffLat;
  double? dropoffLng;
  String? cargoWeight;
  String? cargoDescription;
  String? preferredVehicleType;
  String? pickupDate;
  String? pickupTimePreference;
  String? specialRequirements;
  String? budgetRangeMin;
  String? budgetRangeMax;

  CreateOrderRequest(
      {this.pickupCity,
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
        this.budgetRangeMax});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}
