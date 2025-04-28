class AdAdvertisementsModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AdAdvertisementsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  AdAdvertisementsModel.fromJson(Map<String, dynamic> json) {
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
  String? adSizeId;
  int? price;
  String? status;
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
    this.adSizeId,
    this.price,
    this.status,
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
    adSizeId = json['adSizeId'];
    price = json['price'];
    status = json['status'];
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
    data['adSizeId'] = adSizeId;
    data['price'] = price;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
