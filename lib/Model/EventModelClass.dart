class EventModelClass {
  int status;
  String message;
  List<Data> data;

  EventModelClass({this.status, this.message, this.data});

  EventModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String eventName;
  String eventDesc;
  String eventDate;
  String eventLocation;
  String venueName;
  String venueLocation;
  String venueGooglemap;
  String eventdata1;
  String eventcontain1;
  String eventdata2;
  String eventcontain2;
  String eventdata3;
  String eventcontain3;
  String buttonName;
  String videoUrl;
  String eventNoPrefix;
  String eventNo;
  String facebookLink;
  String twitterLink;
  String youtubeLink;
  String linkdinLink;
  String instagramLink;
  List<TablesList> tablesList;
  List<String> sliderImages;

  Data(
      {this.eventName,
        this.eventDesc,
        this.eventDate,
        this.eventLocation,
        this.venueName,
        this.venueLocation,
        this.venueGooglemap,
        this.eventdata1,
        this.eventcontain1,
        this.eventdata2,
        this.eventcontain2,
        this.eventdata3,
        this.eventcontain3,
        this.buttonName,
        this.videoUrl,
        this.eventNoPrefix,
        this.eventNo,
        this.facebookLink,
        this.twitterLink,
        this.youtubeLink,
        this.linkdinLink,
        this.instagramLink,
        this.tablesList,
        this.sliderImages});

  Data.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    eventDesc = json['event_desc'];
    eventDate = json['event_date'];
    eventLocation = json['event_location'];
    venueName = json['venue_name'];
    venueLocation = json['venue_location'];
    venueGooglemap = json['venue_googlemap'];
    eventdata1 = json['eventdata_1'];
    eventcontain1 = json['eventcontain_1'];
    eventdata2 = json['eventdata_2'];
    eventcontain2 = json['eventcontain_2'];
    eventdata3 = json['eventdata_3'];
    eventcontain3 = json['eventcontain_3'];
    buttonName = json['button_name'];
    videoUrl = json['video_url'];
    eventNoPrefix = json['event_no_prefix'];
    eventNo = json['event_no'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    youtubeLink = json['youtube_link'];
    linkdinLink = json['linkdin_link'];
    instagramLink = json['instagram_link'];
    if (json['tables_list'] != null) {
      tablesList = <TablesList>[];
      json['tables_list'].forEach((v) {
        tablesList.add(new TablesList.fromJson(v));
      });
    }
    sliderImages = json['slider_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_name'] = this.eventName;
    data['event_desc'] = this.eventDesc;
    data['event_date'] = this.eventDate;
    data['event_location'] = this.eventLocation;
    data['venue_name'] = this.venueName;
    data['venue_location'] = this.venueLocation;
    data['venue_googlemap'] = this.venueGooglemap;
    data['eventdata_1'] = this.eventdata1;
    data['eventcontain_1'] = this.eventcontain1;
    data['eventdata_2'] = this.eventdata2;
    data['eventcontain_2'] = this.eventcontain2;
    data['eventdata_3'] = this.eventdata3;
    data['eventcontain_3'] = this.eventcontain3;
    data['button_name'] = this.buttonName;
    data['video_url'] = this.videoUrl;
    data['event_no_prefix'] = this.eventNoPrefix;
    data['event_no'] = this.eventNo;
    data['facebook_link'] = this.facebookLink;
    data['twitter_link'] = this.twitterLink;
    data['youtube_link'] = this.youtubeLink;
    data['linkdin_link'] = this.linkdinLink;
    data['instagram_link'] = this.instagramLink;
    if (this.tablesList != null) {
      data['tables_list'] = this.tablesList.map((v) => v.toJson()).toList();
    }
    data['slider_images'] = this.sliderImages;
    return data;
  }
}

class TablesList {
  String tableName;
  String tablePrice;
  int available;
  String buttonLink;

  TablesList(
      {this.tableName, this.tablePrice, this.available, this.buttonLink});

  TablesList.fromJson(Map<String, dynamic> json) {
    tableName = json['table_name'];
    tablePrice = json['table_price'];
    available = json['available'];
    buttonLink = json['button_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['table_name'] = this.tableName;
    data['table_price'] = this.tablePrice;
    data['available'] = this.available;
    data['button_link'] = this.buttonLink;
    return data;
  }
}
