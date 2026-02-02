class SignupRequest {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? gender;
  String? gst_number;

  SignupRequest(
      {this.fName,this.lName, this.email, this.phone, this.gender, this.gst_number});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    fName = json['firstname'];
    lName = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    gst_number = json['gst_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.fName;
    data['lastname'] = this.lName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['gst_number'] = this.gst_number;
    return data;
  }
}
