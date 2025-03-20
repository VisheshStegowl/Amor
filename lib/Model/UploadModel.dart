class UploadModel {
  int status;
  String message;
  String url;

  UploadModel({this.status, this.message, this.url});

  UploadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['url'] = this.url;
    return data;
  }
}
