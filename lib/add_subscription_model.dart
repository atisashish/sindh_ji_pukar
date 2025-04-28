class AdSubscriptionModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AdSubscriptionModel({this.success, this.statusCode, this.message, this.data});

  AdSubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? shopName;
  String? address;
  String? email;
  String? gst;
  String? phone;
  String? planId;
  int? price;
  String? startDate;
  String? endDate;
  String? status;
  String? paymentStatus;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.name,
    this.shopName,
    this.address,
    this.email,
    this.gst,
    this.phone,
    this.planId,
    this.price,
    this.startDate,
    this.endDate,
    this.status,
    this.paymentStatus,
    this.isDeleted,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shopName = json['shopName'];
    address = json['address'];
    email = json['email'];
    gst = json['gst'];
    phone = json['phone'];
    planId = json['planId'];
    price = json['price'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['shopName'] = shopName;
    data['address'] = address;
    data['email'] = email;
    data['gst'] = gst;
    data['phone'] = phone;
    data['planId'] = planId;
    data['price'] = price;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    data['paymentStatus'] = paymentStatus;
    data['isDeleted'] = isDeleted;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
