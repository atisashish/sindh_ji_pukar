class SendOtpModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  SendOtpModel({this.success, this.statusCode, this.message, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? otp;
  String? phone;

  Data({this.otp, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['phone'] = phone;
    return data;
  }
}
