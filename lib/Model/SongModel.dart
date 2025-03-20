class SongModel {
  int status;
  String message;
  List<Data> data;
  dynamic perPage;
  dynamic currentPage;
  dynamic lastPage;

  SongModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  SongModel.fromJson(Map<String, dynamic> json) {
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
  dynamic favouritesId;
  dynamic playlistId;
  dynamic playlistsongsId;
  dynamic menuId;
  dynamic categoryId;
  dynamic categoryitemsId;
  dynamic songId;
  String songImage;
  String songName;
  String songArtist;
  String song;
  String songDuration;
  bool likesStatus;
  int likesCount;
  bool favouritesStatus;
  int favouritesCount;
  int totalPlayed;
  int totalShared;
  bool totalSharedStatus;
  bool playlistStatus;
  int playlistStatusCount;
  String createdAt;

  Data(
      {this.favouritesId,
        this.playlistId,
        this.playlistsongsId,
        this.menuId,
        this.categoryId,
        this.categoryitemsId,
        this.songId,
        this.songImage,
        this.songName,
        this.songArtist,
        this.song,
        this.songDuration,
        this.likesStatus,
        this.likesCount,
        this.favouritesStatus,
        this.favouritesCount,
        this.totalPlayed,
        this.totalShared,
        this.totalSharedStatus,
        this.playlistStatus,
        this.playlistStatusCount,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    favouritesId = json['favourites_id'];
    playlistId = json['playlist_id'];
    playlistsongsId = json['playlistsongs_id'];
    menuId = json['menu_id'];
    categoryId = json['category_id'];
    categoryitemsId = json['categoryitems_id'];
    songId = json['song_id'];
    songImage = json['song_image'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    song = json['song'];
    songDuration = json['song_duration'];
    likesStatus = json['likes_status'];
    likesCount = json['likes_count'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
    totalSharedStatus = json['total_shared_status'];
    playlistStatus = json['playlist_status'];
    playlistStatusCount = json['playlist_status_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favourites_id'] = this.favouritesId;
    data['playlist_id'] = this.playlistId;
    data['playlistsongs_id'] = this.playlistsongsId;
    data['menu_id'] = this.menuId;
    data['category_id'] = this.categoryId;
    data['categoryitems_id'] = this.categoryitemsId;
    data['song_id'] = this.songId;
    data['song_image'] = this.songImage;
    data['song_name'] = this.songName;
    data['song_artist'] = this.songArtist;
    data['song'] = this.song;
    data['song_duration'] = this.songDuration;
    data['likes_status'] = this.likesStatus;
    data['likes_count'] = this.likesCount;
    data['favourites_status'] = this.favouritesStatus;
    data['favourites_count'] = this.favouritesCount;
    data['total_played'] = this.totalPlayed;
    data['total_shared'] = this.totalShared;
    data['total_shared_status'] = this.totalSharedStatus;
    data['playlist_status'] = this.playlistStatus;
    data['playlist_status_count'] = this.playlistStatusCount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
