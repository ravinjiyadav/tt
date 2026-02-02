class BasicResponse {
  bool? success;
  String? msg;

  BasicResponse({this.success, this.msg});

  BasicResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.msg;
    return data;
  }
}
