class ServiceListModel {
  bool? status;
  String? message;
  List<StoreList>? storeList;

  ServiceListModel({this.status, this.message, this.storeList});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['StoreList'] != null) {
      storeList = <StoreList>[];
      json['StoreList'].forEach((v) {
        storeList!.add(StoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (storeList != null) {
      data['StoreList'] = storeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreList {
  int? id;
  String? storeName;
  String? storeDescription;
  String? price;
  List<StoreImages>? storeImages;
  List<StoreAttachments>? storeAttachments;

  StoreList(
      {this.id,
      this.storeName,
      this.storeDescription,
      this.price,
      this.storeImages,
      this.storeAttachments});

  StoreList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    price = json['price'];
    if (json['store_attachments'] != null) {
      storeImages = <StoreImages>[];
      json['store_images'].forEach((v) {
        storeImages!.add(StoreImages.fromJson(v));
      });
    }
    if (json['store_attachments'] != null) {
      storeAttachments = <StoreAttachments>[];
      json['store_attachments'].forEach((v) {
        storeAttachments!.add(StoreAttachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_name'] = storeName;
    data['store_description'] = storeDescription;
    data['price'] = price;
    if (storeImages != null) {
      data['store_images'] = storeImages!.map((v) => v.toJson()).toList();
    }
    if (storeAttachments != null) {
      data['store_attachments'] =
          storeAttachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreImages {
  int? id;
  String? url;

  StoreImages({this.id, this.url});

  StoreImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class StoreAttachments {
  int? id;
  String? url;

  StoreAttachments({this.id, this.url});

  StoreAttachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}
