class DailyShowModel {
  int status;
  String message;
  List<DailyShowData> data;

  DailyShowModel({this.status, this.message, this.data});

  DailyShowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DailyShowData>[];
      json['data'].forEach((v) {
        data.add(new DailyShowData.fromJson(v));
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

class DailyShowData {
  int eventId;
  String eventImage;
  String eventName;
  String eventDays;
  String eventDescription;
  String eventStartTime;
  String eventEndTime;

  DailyShowData(
      {this.eventId,
        this.eventImage,
        this.eventName,
        this.eventDays,
        this.eventDescription,
        this.eventStartTime,
        this.eventEndTime});

  DailyShowData.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventImage = json['event_image'];
    eventName = json['event_name'];
    eventDays = json['event_days'];
    eventDescription = json['event_description'];
    eventStartTime = json['event_start_time'];
    eventEndTime = json['event_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_image'] = this.eventImage;
    data['event_name'] = this.eventName;
    data['event_days'] = this.eventDays;
    data['event_description'] = this.eventDescription;
    data['event_start_time'] = this.eventStartTime;
    data['event_end_time'] = this.eventEndTime;
    return data;
  }
}
