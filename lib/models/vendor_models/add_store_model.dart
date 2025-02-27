// class AddStoreModel {
//   bool? status;
//   String? message;
//   int? serviceId;

//   AddStoreModel({this.status, this.message, this.serviceId});

//   AddStoreModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     serviceId = json["service_id"];
//   }

//   static List<AddStoreModel> fromList(List<Map<String, dynamic>> list) {
//     return list.map(AddStoreModel.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["status"] = status;
//     data["message"] = message;
//     data["service_id"] = serviceId;
//     return data;
//   }
// }
class AddStoreModel {
  bool? status;
  String? message;
  int? serviceId;

  AddStoreModel({this.status, this.message, this.serviceId});

  AddStoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['service_id'] = serviceId;
    return data;
  }
}
