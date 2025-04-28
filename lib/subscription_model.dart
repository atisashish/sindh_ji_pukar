class SubscriptionListModel {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  SubscriptionListModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? shopName;
  String? address;
  String? email;
  String? gst;
  String? phone;
  PlanId? planId;
  int? price;
  String? startDate;
  String? endDate;
  String? status;
  String? paymentStatus;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
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
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    shopName = json['shopName'];
    address = json['address'];
    email = json['email'];
    gst = json['gst'];
    phone = json['phone'];
    planId = json['planId'] != null ? PlanId.fromJson(json['planId']) : null;
    price = json['price'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['shopName'] = shopName;
    data['address'] = address;
    data['email'] = email;
    data['gst'] = gst;
    data['phone'] = phone;
    if (planId != null) {
      data['planId'] = planId!.toJson();
    }
    data['price'] = price;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    data['paymentStatus'] = paymentStatus;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class PlanId {
  String? sId;
  String? name;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PlanId({
    this.sId,
    this.name,
    this.price,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  PlanId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
