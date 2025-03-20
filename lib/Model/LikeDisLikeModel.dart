class LikeDisLikeModel {
  int status;
  String message;
  bool likeStatus;

  LikeDisLikeModel({this.status, this.message, this.likeStatus});

  LikeDisLikeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
