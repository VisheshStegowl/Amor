class SongCategoryModel {
  int status;
  String message;
  List<Data> data;
  String perPage;
  int currentPage;
  int lastPage;

  SongCategoryModel(
      {this.status,
        this.message,
        this.data,
        this.perPage,
        this.currentPage,
        this.lastPage});

  SongCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int songcategoryId;
  String name;
  String image;
  String artist;

  Data({this.songcategoryId, this.name, this.image, this.artist});

  Data.fromJson(Map<String, dynamic> json) {
    songcategoryId = json['songcategory_id'];
    name = json['name'];
    image = json['image'];
    artist = json['artist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songcategory_id'] = this.songcategoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['artist'] = this.artist;
    return data;
  }
}
