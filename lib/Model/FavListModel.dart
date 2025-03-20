class FavListModel {
  int status;
  String message;
  List<Data> data;
  int perPage;
  int currentPage;
  int lastPage;

  FavListModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  FavListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<Data>();
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
  String songsCategoryItemsId;
  String songsCategoryId;
  String playlistId;
  String playlistSongsId;
  int favouritesId;
  int songId;
  String songName;
  String songArtist;
  String songImage;
  String song;
  String songDuration;
  String songDescription;
  String createdAt;

  Data(
      {this.songsCategoryItemsId,
        this.songsCategoryId,
        this.playlistId,
        this.playlistSongsId,
        this.favouritesId,
        this.songId,
        this.songName,
        this.songArtist,
        this.songImage,
        this.song,
        this.songDuration,
        this.songDescription,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    songsCategoryItemsId = json['songcategoryitems_id'];
    songsCategoryId = json['songcategory_id'];
    playlistId = json['playlist_id'];
    playlistSongsId = json['playlist_songs_id'];
    favouritesId = json['favourites_id'];
    songId = json['song_id'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songImage = json['song_image'];
    song = json['song'];
    songDuration = json['song_duration'];
    songDescription = json['song_description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songcategoryitems_id'] = this.songsCategoryItemsId;
    data['songcategory_id'] = this.songsCategoryId;
    data['playlist_id'] = this.playlistId;
    data['playlist_songs_id'] = this.playlistSongsId;
    data['favourites_id'] = this.favouritesId;
    data['song_id'] = this.songId;
    data['song_name'] = this.songName;
    data['song_artist'] = this.songArtist;
    data['song_image'] = this.songImage;
    data['song'] = this.song;
    data['song_duration'] = this.songDuration;
    data['song_description'] = this.songDescription;
    data['created_at'] = this.createdAt;
    return data;
  }
}
