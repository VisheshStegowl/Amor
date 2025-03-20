class CMSModel {
  int status;
  String message;
  List<LogoData> logoData;
  List<AboutusData> aboutusData;
  List<ContactusData> contactusData;
  List<CopyrightData> copyrightData;
  List<DownloadourappData> downloadourappData;
  List<SocialmediaData> socialmediaData;
  List<HomesliderData> homesliderData;
  List<ApphomesliderData> apphomesliderData;
  List<IntroductionsliderData> introductionsliderData;
  List<SponsorbannerData> sponsorbannerData;
  List<SongcategoryData> songcategoryData;
  List<SongData> songData;

  CMSModel(
      {this.status,
        this.message,
        this.logoData,
        this.aboutusData,
        this.contactusData,
        this.copyrightData,
        this.downloadourappData,
        this.socialmediaData,
        this.homesliderData,
        this.apphomesliderData,
        this.introductionsliderData,
        this.sponsorbannerData,
        this.songcategoryData,
        this.songData});

  CMSModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['logo_data'] != null) {
      logoData = new List<LogoData>();
      json['logo_data'].forEach((v) {
        logoData.add(new LogoData.fromJson(v));
      });
    }
    if (json['aboutus_data'] != null) {
      aboutusData = new List<AboutusData>();
      json['aboutus_data'].forEach((v) {
        aboutusData.add(new AboutusData.fromJson(v));
      });
    }
    if (json['contactus_data'] != null) {
      contactusData = new List<ContactusData>();
      json['contactus_data'].forEach((v) {
        contactusData.add(new ContactusData.fromJson(v));
      });
    }
    if (json['copyright_data'] != null) {
      copyrightData = new List<CopyrightData>();
      json['copyright_data'].forEach((v) {
        copyrightData.add(new CopyrightData.fromJson(v));
      });
    }
    if (json['downloadourapp_data'] != null) {
      downloadourappData = new List<DownloadourappData>();
      json['downloadourapp_data'].forEach((v) {
        downloadourappData.add(new DownloadourappData.fromJson(v));
      });
    }
    if (json['socialmedia_data'] != null) {
      socialmediaData = new List<SocialmediaData>();
      json['socialmedia_data'].forEach((v) {
        socialmediaData.add(new SocialmediaData.fromJson(v));
      });
    }
    if (json['homeslider_data'] != null) {
      homesliderData = new List<HomesliderData>();
      json['homeslider_data'].forEach((v) {
        homesliderData.add(new HomesliderData.fromJson(v));
      });
    }
    if (json['apphomeslider_data'] != null) {
      apphomesliderData = new List<ApphomesliderData>();
      json['apphomeslider_data'].forEach((v) {
        apphomesliderData.add(new ApphomesliderData.fromJson(v));
      });
    }
    if (json['introductionslider_data'] != null) {
      introductionsliderData = new List<IntroductionsliderData>();
      json['introductionslider_data'].forEach((v) {
        introductionsliderData.add(new IntroductionsliderData.fromJson(v));
      });
    }
    if (json['sponsorbanner_data'] != null) {
      sponsorbannerData = new List<SponsorbannerData>();
      json['sponsorbanner_data'].forEach((v) {
        sponsorbannerData.add(new SponsorbannerData.fromJson(v));
      });
    }
    if (json['songcategory_data'] != null) {
      songcategoryData = new List<SongcategoryData>();
      json['songcategory_data'].forEach((v) {
        songcategoryData.add(new SongcategoryData.fromJson(v));
      });
    }
    if (json['song_data'] != null) {
      songData = new List<SongData>();
      json['song_data'].forEach((v) {
        songData.add(new SongData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.logoData != null) {
      data['logo_data'] = this.logoData.map((v) => v.toJson()).toList();
    }
    if (this.aboutusData != null) {
      data['aboutus_data'] = this.aboutusData.map((v) => v.toJson()).toList();
    }
    if (this.contactusData != null) {
      data['contactus_data'] =
          this.contactusData.map((v) => v.toJson()).toList();
    }
    if (this.copyrightData != null) {
      data['copyright_data'] =
          this.copyrightData.map((v) => v.toJson()).toList();
    }
    if (this.downloadourappData != null) {
      data['downloadourapp_data'] =
          this.downloadourappData.map((v) => v.toJson()).toList();
    }
    if (this.socialmediaData != null) {
      data['socialmedia_data'] =
          this.socialmediaData.map((v) => v.toJson()).toList();
    }
    if (this.homesliderData != null) {
      data['homeslider_data'] =
          this.homesliderData.map((v) => v.toJson()).toList();
    }
    if (this.apphomesliderData != null) {
      data['apphomeslider_data'] =
          this.apphomesliderData.map((v) => v.toJson()).toList();
    }
    if (this.introductionsliderData != null) {
      data['introductionslider_data'] =
          this.introductionsliderData.map((v) => v.toJson()).toList();
    }
    if (this.sponsorbannerData != null) {
      data['sponsorbanner_data'] =
          this.sponsorbannerData.map((v) => v.toJson()).toList();
    }
    if (this.songcategoryData != null) {
      data['songcategory_data'] =
          this.songcategoryData.map((v) => v.toJson()).toList();
    }
    if (this.songData != null) {
      data['song_data'] = this.songData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LogoData {
  int logoId;
  String name;
  String image;
  String footerBg;

  LogoData({this.logoId, this.name, this.image, this.footerBg});

  LogoData.fromJson(Map<String, dynamic> json) {
    logoId = json['logo_id'];
    name = json['name'];
    image = json['image'];
    footerBg = json['footer_bg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo_id'] = this.logoId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['footer_bg'] = this.footerBg;
    return data;
  }
}

class AboutusData {
  int aboutusId;
  String image;
  String title;
  String description;

  AboutusData({this.aboutusId, this.image, this.title, this.description});

  AboutusData.fromJson(Map<String, dynamic> json) {
    aboutusId = json['aboutus_id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aboutus_id'] = this.aboutusId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class ContactusData {
  int contactusId;
  String email;
  String website;
  String phone;
  String address;

  ContactusData(
      {this.contactusId, this.email, this.website, this.phone, this.address});

  ContactusData.fromJson(Map<String, dynamic> json) {
    contactusId = json['contactus_id'];
    email = json['email'];
    website = json['website'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactus_id'] = this.contactusId;
    data['email'] = this.email;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class CopyrightData {
  int copyrightId;
  String text;

  CopyrightData({this.copyrightId, this.text});

  CopyrightData.fromJson(Map<String, dynamic> json) {
    copyrightId = json['copyright_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['copyright_id'] = this.copyrightId;
    data['text'] = this.text;
    return data;
  }
}

class DownloadourappData {
  int downloadourappId;
  String androidLink;
  String iosLink;
  String durisimoLink;

  DownloadourappData(
      {this.downloadourappId,
        this.androidLink,
        this.iosLink,
        this.durisimoLink});

  DownloadourappData.fromJson(Map<String, dynamic> json) {
    downloadourappId = json['downloadourapp_id'];
    androidLink = json['android_link'];
    iosLink = json['ios_link'];
    durisimoLink = json['durisimo_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['downloadourapp_id'] = this.downloadourappId;
    data['android_link'] = this.androidLink;
    data['ios_link'] = this.iosLink;
    data['durisimo_link'] = this.durisimoLink;
    return data;
  }
}

class SocialmediaData {
  int socialmediaId;
  String facebookLink;
  String instagramLink;
  String twitterLink;
  String youtubeLink;
  String androidKey;
  String iosKey;
  String androidInterstitial;
  String iosInterstitial;

  SocialmediaData(
      {this.socialmediaId,
        this.facebookLink,
        this.instagramLink,
        this.twitterLink,
        this.youtubeLink,
        this.androidKey,
        this.iosKey,
      this.androidInterstitial,
      this.iosInterstitial});

  SocialmediaData.fromJson(Map<String, dynamic> json) {
    socialmediaId = json['socialmedia_id'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    youtubeLink = json['youtube_link'];
    androidKey = json['android_key'];
    iosKey = json['ios_key'];
    androidInterstitial = json['android_interstitial'];
    iosInterstitial = json['ios_interstitial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialmedia_id'] = this.socialmediaId;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['youtube_link'] = this.youtubeLink;
    data['android_key'] = this.androidKey;
    data['ios_key'] = this.iosKey;
    data['android_interstitial'] = this.androidInterstitial;
    data['ios_interstitial'] = this.iosInterstitial;
    return data;
  }
}

class HomesliderData {
  int homesliderId;
  String image;

  HomesliderData({this.homesliderId, this.image});

  HomesliderData.fromJson(Map<String, dynamic> json) {
    homesliderId = json['homeslider_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeslider_id'] = this.homesliderId;
    data['image'] = this.image;
    return data;
  }
}

class ApphomesliderData {
  Null homesliderId;
  String image;

  ApphomesliderData({this.homesliderId, this.image});

  ApphomesliderData.fromJson(Map<String, dynamic> json) {
    homesliderId = json['homeslider_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeslider_id'] = this.homesliderId;
    data['image'] = this.image;
    return data;
  }
}

class IntroductionsliderData {
  Null homesliderId;
  String image;

  IntroductionsliderData({this.homesliderId, this.image});

  IntroductionsliderData.fromJson(Map<String, dynamic> json) {
    homesliderId = json['homeslider_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeslider_id'] = this.homesliderId;
    data['image'] = this.image;
    return data;
  }
}

class SponsorbannerData {
  int sponsorbannerId;
  String image;
  String url;

  SponsorbannerData({this.sponsorbannerId, this.image, this.url});

  SponsorbannerData.fromJson(Map<String, dynamic> json) {
    sponsorbannerId = json['sponsorbanner_id'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sponsorbanner_id'] = this.sponsorbannerId;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}

class SongcategoryData {
  int songcategoryId;
  String name;
  String image;

  SongcategoryData({this.songcategoryId, this.name, this.image});

  SongcategoryData.fromJson(Map<String, dynamic> json) {
    songcategoryId = json['songcategory_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songcategory_id'] = this.songcategoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class SongData {
  String playlistsongId;
  String playlistId;
  String favouritesId;
  int songcategoryitemId;
  int songcategoryId;
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
