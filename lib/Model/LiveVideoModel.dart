class LiveVideoModel {
  int status;
  String message;
  List<LiveVideo> data;

  LiveVideoModel({this.status, this.message, this.data});

  LiveVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<LiveVideo>();
      json['data'].forEach((v) {
        data.add(new LiveVideo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveVideo {
  int livevideoId;
  String image;
  String name;
  String url;
  String description;
  String sliderImg;
  bool likeStatus;
  int likeCount;
  LiveVideo(
      {this.livevideoId,
        this.image,
        this.name,
        this.url,
        this.description,
        this.likeStatus,
        this.sliderImg,
      this.likeCount});

  LiveVideo.fromJson(Map<String, dynamic> json) {
    livevideoId = json['livevideo_id'];
    image = json['image'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    likeStatus = json['like_status'];
    likeCount = json['like_count'];
    sliderImg = json['slider_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['livevideo_id'] = this.livevideoId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['url'] = this.url;
    data['description'] = this.description;
    data['like_status'] = this.likeStatus;
    data['like_count'] = this.likeCount;
    return data;
  }
}
