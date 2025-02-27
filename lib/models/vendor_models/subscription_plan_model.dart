// class SubscriptionDetailModel {
//   bool? status;
//   String? message;
//   List<SubscriptionDetail>? subscriptionDetail;

//   SubscriptionDetailModel({this.status, this.message, this.subscriptionDetail});

//   SubscriptionDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     subscriptionDetail = json["subscriptionDetail"] == null
//         ? null
//         : (json["subscriptionDetail"] as List)
//             .map((e) => SubscriptionDetail.fromJson(e))
//             .toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["status"] = status;
//     data["message"] = message;
//     if (subscriptionDetail != null) {
//       data["subscriptionDetail"] =
//           subscriptionDetail?.map((e) => e.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SubscriptionDetail {
//   int? id;
//   String? planName;
//   String? price;
//   String? validityDay;
//   String? perMonth;
//   String? image;

//   SubscriptionDetail({
//     this.id,
//     this.planName,
//     this.price,
//     this.validityDay,
//     this.perMonth,
//     this.image,
//   });

//   SubscriptionDetail.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     planName = json["plan_name"];
//     price = json["price"];
//     validityDay = json["validity_day"];
//     perMonth = json["per_month"];
//     image = json["image"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["id"] = id;
//     data["plan_name"] = planName;
//     data["price"] = price;
//     data["validity_day"] = validityDay;
//     data["per_month"] = perMonth;
//     data["image"] = image;
//     return data;
//   }
// }

// class SubscriptionDetailModel {
//   bool? status;
//   String? message;
//   List<SubscriptionDetail>? subscriptionDetail;

//   SubscriptionDetailModel({this.status, this.message, this.subscriptionDetail});

//   SubscriptionDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['subscriptionDetail'] != null) {
//       subscriptionDetail = <SubscriptionDetail>[];
//       json['subscriptionDetail'].forEach((v) {
//         subscriptionDetail!.add(SubscriptionDetail.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     if (subscriptionDetail != null) {
//       data['subscriptionDetail'] =
//           subscriptionDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class SubscriptionDetail {
//   int? id;
//   String? planName;
//   String? description;
//   String? price;
//   String? validityDay;
//   List<PlanServices>? planServices;

//   SubscriptionDetail(
//       {this.id,
//       this.planName,
//       this.description,
//       this.price,
//       this.validityDay,
//       this.planServices});

//   SubscriptionDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     planName = json['plan_name'];
//     description = json['description'];
//     price = json['price'];
//     validityDay = json['validity_day'];
//     if (json['plan_services'] != null) {
//       planServices = <PlanServices>[];
//       json['plan_services'].forEach((v) {
//         planServices!.add(PlanServices.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['plan_name'] = planName;
//     data['description'] = description;
//     data['price'] = price;
//     data['validity_day'] = validityDay;
//     if (planServices != null) {
//       data['plan_services'] =
//           planServices!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class PlanServices {
//   String? planServices;
//   int? status;

//   PlanServices({this.planServices, this.status});

//   PlanServices.fromJson(Map<String, dynamic> json) {
//     planServices = json['plan_services'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['plan_services'] = planServices;
//     data['status'] = status;
//     return data;
//   }
// }

class SubscriptionDetailModel {
  bool? status;
  String? message;
  List<SubscriptionDetail>? subscriptionDetail;

  SubscriptionDetailModel({this.status, this.message, this.subscriptionDetail});

  SubscriptionDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['subscriptionDetail'] != null) {
      subscriptionDetail = <SubscriptionDetail>[];
      json['subscriptionDetail'].forEach((v) {
        subscriptionDetail!.add(SubscriptionDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (subscriptionDetail != null) {
      data['subscriptionDetail'] =
          subscriptionDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionDetail {
  int? id;
  String? planName;
  String? description;
  String? price;
  String? validityDay;
  String? currencyValue;
  List<PlanServices>? planServices;

  SubscriptionDetail(
      {this.id,
      this.planName,
      this.description,
      this.price,
      this.validityDay,
      this.currencyValue,
      this.planServices});

  SubscriptionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    description = json['description'];
    price = json['price'];
    validityDay = json['validity_day'];
    currencyValue = json['currency_value'];
    if (json['plan_services'] != null) {
      planServices = <PlanServices>[];
      json['plan_services'].forEach((v) {
        planServices!.add(PlanServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_name'] = planName;
    data['description'] = description;
    data['price'] = price;
    data['validity_day'] = validityDay;
    data['currency_value'] = currencyValue;
    if (planServices != null) {
      data['plan_services'] = planServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanServices {
  String? planServices;
  int? status;

  PlanServices({this.planServices, this.status});

  PlanServices.fromJson(Map<String, dynamic> json) {
    planServices = json['plan_services'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_services'] = planServices;
    data['status'] = status;
    return data;
  }
}
