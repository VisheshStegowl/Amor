class CoreResponseModel {
  int status;
  String message;
  String url;
  bool favouritesStatus;
  int favouritesCount;
  // ignore: non_constant_identifier_names
  dynamic playlist_id;
  // ignore: non_constant_identifier_names
  int total_shared;
  // ignore: non_constant_identifier_names
  bool total_shared_status;
  // ignore: non_constant_identifier_names
  bool videos_like_status;
  // ignore: non_constant_identifier_names
  int videos_like_count;
  List<LivetvMenuData> livetvMenuData;
  List<RadioMenuData> radioMenuData;

  CoreResponseModel(
      // ignore: non_constant_identifier_names
      {this.status, this.message, this.favouritesStatus, this.total_shared_status, this.videos_like_count, this.videos_like_status, this.favouritesCount, this.playlist_id, this.total_shared, this.livetvMenuData, this.radioMenuData});

  CoreResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    url = json['url'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
    playlist_id = json['playlist_id'];
    total_shared = json['total_shared'];
    total_shared_status = json['total_shared_status'];
    videos_like_count = json['videos_like_count'];
    videos_like_status = json['videos_like_status'];
    if (json['livetv_menu_data'] != null) {
      // ignore: deprecated_member_use
      livetvMenuData = new List<LivetvMenuData>();
      json['livetv_menu_data'].forEach((v) {
        livetvMenuData.add(new LivetvMenuData.fromJson(v));
      });
    }
    if (json['radio_menu_data'] != null) {
      // ignore: deprecated_member_use
      radioMenuData = new List<RadioMenuData>();
      json['radio_menu_data'].forEach((v) {
        radioMenuData.add(new RadioMenuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['url'] = this.url;
    data['favourites_status'] = this.favouritesStatus;
    data['favourites_count'] = this.favouritesCount;
    data['playlist_id'] = this.playlist_id;
    data['total_shared'] = this.total_shared;
    data['total_shared_status'] = this.total_shared_status;
    data['videos_like_count'] = this.videos_like_count;
    data['videos_like_status'] = this.videos_like_status;
    if (this.livetvMenuData != null) {
      data['livetv_menu_data'] =
          this.livetvMenuData.map((v) => v.toJson()).toList();
    }
    if (this.radioMenuData != null) {
      data['radio_menu_data'] =
          this.radioMenuData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LivetvMenuData {
  int menuId;
  bool visibleStatus;

  LivetvMenuData({this.menuId, this.visibleStatus});

  LivetvMenuData.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    visibleStatus = json['visible_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['visible_status'] = this.visibleStatus;
    return data;
  }
}

class RadioMenuData {
  int menuId;
  bool visibleStatus;

  RadioMenuData({this.menuId, this.visibleStatus});

  RadioMenuData.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    visibleStatus = json['visible_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['visible_status'] = this.visibleStatus;
    return data;
  }
}