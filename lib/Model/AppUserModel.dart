class AppUserModel {
  int status;
  String message;
  int userId;
  String fcmId;
  String deviceType;
  String token;

  AppUserModel(
      {this.status,
        this.message,
        this.userId,
        this.fcmId,
        this.deviceType,
        this.token});

  AppUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    fcmId = json['fcm_id'];
    deviceType = json['device_type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['fcm_id'] = this.fcmId;
    data['device_type'] = this.deviceType;
    data['token'] = this.token;
    return data;
  }
}
