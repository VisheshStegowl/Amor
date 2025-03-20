class LiveRadioModel {
  int status;
  String message;
  List<LiveRadioData> data;

  LiveRadioModel({this.status, this.message, this.data});

  LiveRadioModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<LiveRadioData>();
      json['data'].forEach((v) {
        data.add(new LiveRadioData.fromJson(v));
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

class LiveRadioData {
  int liveRadioId;
  String name;
  // String image;
  List<String> image;
  String logoImage;
  String url;

  LiveRadioData({this.liveRadioId, this.name, this.image, this.url});

  LiveRadioData.fromJson(Map<String, dynamic> json) {
    liveRadioId = json['live_radio_id'];
    name = json['song_name'];
    logoImage = json['radio_logo'];
    image = json['song_image'].cast<String>();
    url = json['song'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['live_radio_id'] = this.liveRadioId;
    data['song_name'] = this.name;
    data['song_image'] = this.image;
    data['song'] = this.url;
    data['radio_logo'] = this.logoImage;
    return data;
  }
}
