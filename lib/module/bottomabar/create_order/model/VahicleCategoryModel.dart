class VehicleCategory {
  bool? success;
  List<Vehiclecategory>? data;

  VehicleCategory({this.success, this.data});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Vehiclecategory>[];
      json['data'].forEach((v) {
        data!.add(new Vehiclecategory.fromJson(v));
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

class Vehiclecategory {
  int? id;
  String? name;
  String? description;
  dynamic typicalCapacityMin;
  dynamic typicalCapacityMax;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Vehiclecategory(
      {this.id,
        this.name,
        this.description,
        this.typicalCapacityMin,
        this.typicalCapacityMax,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Vehiclecategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    typicalCapacityMin = json['typical_capacity_min'];
    typicalCapacityMax = json['typical_capacity_max'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['typical_capacity_min'] = this.typicalCapacityMin;
    data['typical_capacity_max'] = this.typicalCapacityMax;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
