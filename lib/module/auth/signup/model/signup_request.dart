class SignupRequest {
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? gst_number;

  SignupRequest(
      {this.name, this.email, this.phone, this.gender, this.gst_number});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    name = json['firstname'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    gst_number = json['gst_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['transport_name'] = this.gst_number;
    return data;
  }
}
