class SearchListModel {
  int status;
  String message;
  List<SongData> data;
  int perPage;
  int currentPage;
  int lastPage;

  SearchListModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  SearchListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
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
  String playlistsongId;
  String playlistId;
  String favouritesId;
  String songcategoryitemId;
  String songcategoryId;
  int songId;
  String songImage;
  String songName;
  String songArtist;
  String song;
  String songDuration;
  bool favouritesStatus;
  bool likesStatus;
  int likesCount;

  SongData(
      {this.playlistsongId,
        this.playlistId,
        this.favouritesId,
        this.songcategoryitemId,
        this.songcategoryId,
        this.songId,
        this.songImage,
        this.songName,
        this.songArtist,
        this.song,
        this.songDuration,
        this.favouritesStatus,
        this.likesStatus,
        this.likesCount});

  SongData.fromJson(Map<String, dynamic> json) {
    playlistsongId = json['playlistsong_id'];
    playlistId = json['playlist_id'];
    favouritesId = json['favourites_id'];
    songcategoryitemId = json['songcategoryitem_id'];
    songcategoryId = json['songcategory_id'];
    songId = json['song_id'];
    songImage = json['song_image'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    song = json['song'];
    songDuration = json['song_duration'];
    favouritesStatus = json['favourites_status'];
    likesStatus = json['likes_status'];
    likesCount = json['likes_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlistsong_id'] = this.playlistsongId;
    data['playlist_id'] = this.playlistId;
    data['favourites_id'] = this.favouritesId;
    data['songcategoryitem_id'] = this.songcategoryitemId;
    data['songcategory_id'] = this.songcategoryId;
    data['song_id'] = this.songId;
    data['song_image'] = this.songImage;
    data['song_name'] = this.songName;
    data['song_artist'] = this.songArtist;
    data['song'] = this.song;
    data['song_duration'] = this.songDuration;
    data['favourites_status'] = this.favouritesStatus;
    data['likes_status'] = this.likesStatus;
    data['likes_count'] = this.likesCount;
    return data;
  }
}
