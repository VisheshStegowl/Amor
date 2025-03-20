class SongListModel {
  int status;
  String message;
  String songsCategoryName;
  List<SongData> data;
  String perPage;
  int currentPage;
  int lastPage;

  SongListModel(
      {this.status,
        this.message,
        this.songsCategoryName,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  SongListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    songsCategoryName = json['songcategory_name'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<SongData>();
      json['data'].forEach((v) {
        data.add(new SongData.fromJson(v));
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
    data['name'] = this.songsCategoryName;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class SongData {
  int songsCategoryItemsId;
  int songsCategoryId;
  String playlistId;
  String playlistSongsId;
  String favouritesId;
  int songId;
  String songName;
  String songArtist;
  String songImage;
  String song;
  String songDuration;
  String songDescription;
  int likeCount;
  bool likeStatus;
  int favouritesCount;
  bool favouritesStatus;
  String createdAt;

  SongData(
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
        this.likeCount,
        this.likeStatus,
        this.favouritesCount,
        this.favouritesStatus,
        this.createdAt});

  SongData.fromJson(Map<String, dynamic> json) {
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
    likeCount = json['like_count'];
    likeStatus = json['like_status'];
    favouritesCount = json['favourites_count'];
    favouritesStatus = json['favourites_status'];
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
    data['like_count'] = this.likeCount;
    data['like_status'] = this.likeStatus;
    data['favourites_count'] = this.favouritesCount;
    data['favourites_status'] = this.favouritesStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
