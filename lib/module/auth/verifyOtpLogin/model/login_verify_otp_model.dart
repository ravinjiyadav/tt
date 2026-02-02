class LoginVerifyOtpModel {
  bool? success;
  String? message;
  Data? data;
  String? token;

  LoginVerifyOtpModel({this.success, this.message, this.data, this.token});

  LoginVerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  int? vendorId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? transportName;
  String? approvalStatus;

  Data(
      {this.id,
        this.vendorId,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.transportName,
        this.approvalStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    transportName = json['transport_name'];
    approvalStatus = json['approval_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['transport_name'] = this.transportName;
    data['approval_status'] = this.approvalStatus;
    return data;
  }
}
