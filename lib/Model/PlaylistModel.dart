class PlaylistModel {
  int status;
  String message;
  List<PlaylistData> data;
  int perPage;
  int currentPage;
  int lastPage;

  PlaylistModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<PlaylistData>();
      json['data'].forEach((v) {
        data.add(new PlaylistData.fromJson(v));
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

class PlaylistData {
  int playlistId;
  int userId;
  String name;
  String date;
  String time;
  int total_song;

  PlaylistData({this.playlistId, this.userId, this.name, this.date, this.time,this.total_song});

  PlaylistData.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    userId = json['user_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    total_song = json['total_song'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['total_song'] = this.total_song;
    return data;
  }
}
