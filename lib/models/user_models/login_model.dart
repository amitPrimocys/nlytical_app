class LoginModel {
  bool? status;
  int? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? mobile;
  String? image;
  int? subscribedUser;
  String? serviceId;
  int? isStore;
  int? storeApproval;
  String? loginType;
  String? message;

  LoginModel(
      {this.status,
      this.userId,
      this.email,
      this.firstName,
      this.lastName,
      this.username,
      this.mobile,
      this.image,
      this.subscribedUser,
      this.serviceId,
      this.isStore,
      this.storeApproval,
      this.loginType,
      this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    mobile = json['mobile'];
    image = json['image'];
    subscribedUser = json['subscribed_user'];
    serviceId = json['service_id'];
    isStore = json['is_store'];
    storeApproval = json['store_approval'];
    loginType = json['login_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_id'] = userId;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['mobile'] = mobile;
    data['image'] = image;
    data['subscribed_user'] = subscribedUser;
    data['service_id'] = serviceId;
    data['is_store'] = isStore;
    data['store_approval'] = storeApproval;
    data['login_type'] = loginType;
    data['message'] = message;
    return data;
  }
}
