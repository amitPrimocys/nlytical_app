// class OtpModel {
//   bool? status;
//   int? userId;
//   String? firstName;
//   String? email;
//   String? role;
//   String? token;
//   String? message;

//   OtpModel(
//       {this.status,
//       this.userId,
//       this.firstName,
//       this.email,
//       this.role,
//       this.token,
//       this.message});

//   OtpModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     userId = json['user_id'];
//     firstName = json['first_name'];
//     email = json['email'];
//     role = json['role'];
//     token = json['token'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = status;
//     data['user_id'] = userId;
//     data['first_name'] = firstName;
//     data['email'] = email;
//     data['role'] = role;
//     data['token'] = token;
//     data['message'] = message;
//     return data;
//   }
// }

class OtpModel {
  bool? status;
  int? userId;
  String? firstName;
  String? mobile;
  String? role;
  String? token;
  String? message;
  int? userSubscription;
  int? serviceId;

  OtpModel(
      {this.status,
      this.userId,
      this.firstName,
      this.mobile,
      this.role,
      this.token,
      this.message,
      this.userSubscription,
      this.serviceId});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    firstName = json['first_name'];
    mobile = json['mobile'];
    role = json['role'];
    token = json['token'];
    message = json['message'];
    userSubscription = json['user_subscription'];
    // serviceId = json['service_id'];
    serviceId = json['service_id'] is String && json['service_id'].isEmpty
        ? 0
        : json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['mobile'] = mobile;
    data['role'] = role;
    data['token'] = token;
    data['message'] = message;
    data['user_subscription'] = userSubscription;
    data['service_id'] = serviceId;
    return data;
  }
}
