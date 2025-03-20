class UserModel {
  int status;
  String message;
  int userId;
  String username;
  String fullname;
  String email;
  String phone;
  String deviceType;
  String fcmId;
  String authToken;
  String accessToken;

  UserModel(
      {this.status,
        this.message,
        this.userId,
        this.username,
        this.fullname,
        this.email,
        this.phone,
        this.deviceType,
        this.fcmId,
        this.authToken,
        this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    deviceType = json['device_type'];
    fcmId = json['fcm_id'];
    authToken = json['auth_token'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['device_type'] = this.deviceType;
    data['fcm_id'] = this.fcmId;
    data['auth_token'] = this.authToken;
    data['access_token'] = this.accessToken;
    return data;
  }
}

class LogOut {
  int status;
  String message;

  LogOut({this.status, this.message});

  LogOut.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
