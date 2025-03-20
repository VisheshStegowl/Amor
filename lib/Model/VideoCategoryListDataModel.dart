class VideoCategoryListDataModel {
  int status;
  String message;
  List<Data> data;
  int perPage;
  int currentPage;
  int lastPage;

  VideoCategoryListDataModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  VideoCategoryListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class Data {
  int videoId;
  String name;
  String description;
  String image;
  String video;
  int videocategoryId;
  String createdAt;

  Data(
      {this.videoId,
        this.name,
        this.description,
        this.image,
        this.video,
        this.videocategoryId,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    videocategoryId = json['videocategory_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['video'] = this.video;
    data['videocategory_id'] = this.videocategoryId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
