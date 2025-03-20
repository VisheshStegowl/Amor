import 'dart:convert';
import 'dart:io';
import 'package:amor_93_7_fm/Model/DailyShowModel.dart';
import 'package:amor_93_7_fm/Model/EventModelClass.dart';
import 'package:amor_93_7_fm/Model/SearchListModel.dart';
import 'package:amor_93_7_fm/Model/TermsAndConditionModelClass.dart';
import 'package:amor_93_7_fm/Model/VideoCategoryDataModel.dart';
import 'package:amor_93_7_fm/Model/VideoCategoryListDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:amor_93_7_fm/Model/AppUserModel.dart';
import 'package:amor_93_7_fm/Model/CMSModel.dart';
import 'package:amor_93_7_fm/Model/CoreResponseModel.dart';
import 'package:amor_93_7_fm/Model/FavListModel.dart';
import 'package:amor_93_7_fm/Model/LikeDisLikeModel.dart';
import 'package:amor_93_7_fm/Model/LiveRadioModel.dart';
import 'package:amor_93_7_fm/Model/LiveVideoModel.dart';
import 'package:amor_93_7_fm/Model/NotificationModel.dart';
import 'package:amor_93_7_fm/Model/PlaylistModel.dart';
import 'package:amor_93_7_fm/Model/PlaylistSongModel.dart';
import 'package:amor_93_7_fm/Model/SongCategoryModel.dart';
import 'package:amor_93_7_fm/Model/SongListModel.dart';
import 'package:amor_93_7_fm/Model/UploadModel.dart';
import 'package:amor_93_7_fm/Model/UserModel.dart';
import 'package:http/http.dart';
import 'package:amor_93_7_fm/Model/bookingModel.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';

import '../Model/MenuModel.dart';

class APIRouter {
  // static const String _baseUrl = "https://djangelsapp.com/djangelsapp/api/";
  static const String _baseUrl = "https://amor937.com/amor937/api/";
  // https://lakalle937.com/lakalleradio/api/terms
  // static const String _eventUrl = "https://lakalle937.com/lakalleradio/api/events";
  static String login = _baseUrl + "login";
  static String appUser = _baseUrl + "appusers";
  static String logout = _baseUrl + "logout";
  static String uploadImg = _baseUrl + "uploads";
  static String cms = _baseUrl + "cms";
  static String booking = _baseUrl + "booking";
  static String notification = _baseUrl + "notifications";
  static String songCategory = _baseUrl + "songcategory/";
  static String menu = _baseUrl + "menu?limit=50&page=";
  static String songList = _baseUrl + "songs?limit=50&page=";
  static String playlist = _baseUrl + "playlist";
  static String playlistSong = _baseUrl + "playlistsong/";
  static String favSong = _baseUrl + "favourites";
  static String playlistSongList = _baseUrl + "playlistsong?limit=50&page=";
  static String liveRadio = _baseUrl + "liveradio";
  static String liveVadio = _baseUrl + "livevideo";
  static String videoLike = _baseUrl + "videolike";
  static String videoCategory = _baseUrl + "videocategory";
  static String videoCategoryList = _baseUrl + "videolistbycat/";
  static String searchList = _baseUrl + "songs_search/";
  static String dailyShows = _baseUrl + 'program';
  static String event = _baseUrl + 'events';
  static String terms = _baseUrl + 'terms';
}

class APIClient {
  Future<UserModel> login(Map<String, dynamic> param) async {
    final response = await post(Uri.parse(APIRouter.login), body: param);
    print(response.body);
    print(param);
    return UserModel.fromJson(json.decode(response.body));
  }

  Future<AppUserModel> appUser(Map<String, dynamic> param) async {
    final response = await post(Uri.parse(APIRouter.appUser), body: param);
    print(APIRouter.appUser);
    print(response.body);
    print(param);
    return AppUserModel.fromJson(json.decode(response.body));
  }

  Future<MenuModel> getArtist(String page) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    final response = await get(Uri.parse(APIRouter.menu + page));
    print("${APIRouter.menu + page}");
    print(response.body);
    return MenuModel.fromJson(json.decode(response.body));
  }

  Future<SearchListModel> getSearchList(String searchText, int page) async {
    Map<String, String> headers = {
      "userid": Constants.userModel.userId.toString()
    };
    final response = await post(
        Uri.parse("${APIRouter.searchList}$searchText?page=$page"),
        body: headers);
    print("${APIRouter.searchList}$searchText?page=$page");
    print(response.body);
    return SearchListModel.fromJson(json.decode(response.body));
  }

  Future<SongCategoryModel> getSongCategory(String type, String page) async {
    String url = "${APIRouter.songCategory}$type?limit=50&page=$page";
    print(url);
    final response = await get(
      Uri.parse(url),
    );
    print(response.body);
    return SongCategoryModel.fromJson(json.decode(response.body));
  }

  Future<CMSModel> getcms() async {
    final response = await get(Uri.parse(APIRouter.cms));
    print(
      "${APIRouter.cms}",
    );
    debugPrint(response.body, wrapWidth: 2000);
    return CMSModel.fromJson(json.decode(response.body));
  }

  Future<BookingModel> getBooking() async {
    final response = await get(Uri.parse(APIRouter.booking));
    print(
      "${APIRouter.booking}",
    );
    debugPrint(response.body, wrapWidth: 1000);
    return BookingModel.fromJson(json.decode(response.body));
  }

  Future<PlaylistModel> getPlaylist(
      Map<String, dynamic> param, String page) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    print("param" + param.toString());
    final response = await post(Uri.parse(APIRouter.playlist), body: param);
    // print("headers: $headers");
    print(APIRouter.playlist);
    print(response.body);
    return PlaylistModel.fromJson(json.decode(response.body));
  }

  Future<SongListModel> getSongList(
      Map<String, dynamic> param, String page) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    print(APIRouter.songList + page);
    // print("headers: $headers");
    print("param" + param.toString());
    final response =
        await post(Uri.parse(APIRouter.songList + page), body: param);
    print(response.body);
    return SongListModel.fromJson(json.decode(response.body));
  }

  Future<PlaylistSongModel> getPlaylistSongList(
      Map<String, dynamic> param, String page) async {
    print(APIRouter.playlistSongList + page);
    print("param" + param.toString());
    final response = await post(
      Uri.parse(APIRouter.playlistSongList + page),
      body: param,
    );
    print(response.body);
    return PlaylistSongModel.fromJson(json.decode(response.body));
  }

  Future<CoreResponseModel> addRemoveFavSong(Map<String, dynamic> param) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    print(APIRouter.favSong + "/add_remove");
    print("Param" + param.toString());
    final response =
        await post(Uri.parse(APIRouter.favSong + "/add_remove"), body: param);
    print(response.body);
    return CoreResponseModel.fromJson(json.decode(response.body));
  }

  Future<CoreResponseModel> createRemovePlaylist(
      Map<String, dynamic> param, String type) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    print(APIRouter.playlist + type);
    print("Param" + param.toString());
    final response = await post(
      Uri.parse(APIRouter.playlist + "/" + type),
      body: param,
    );
    print(response.body);
    return CoreResponseModel.fromJson(json.decode(response.body));
  }

  Future<CoreResponseModel> addSongToPlaylist(
      Map<String, dynamic> param, String type) async {
    String url = APIRouter.playlistSong + type;
    print(url);
    print("Param" + param.toString());
    final response = await post(
      Uri.parse(url),
      body: param,
    );
    print(response.body);
    return CoreResponseModel.fromJson(json.decode(response.body));
  }

  Future<UploadModel> uploadImage(File file) async {
    print(APIRouter.uploadImg);
    var request = MultipartRequest('POST', Uri.parse(APIRouter.uploadImg));
    // String formattedDate = DateFormat('dd-mm-yy-hh-mm-ss').format(
    //     DateTime.now());
    var pic = await MultipartFile.fromPath("image", file.path);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return UploadModel.fromJson(json.decode(responseString));
  }

  Future<NotificationModel> getNotification() async {
    final response = await get(Uri.parse(APIRouter.notification));
    print(response.body);
    return NotificationModel.fromJson(json.decode(response.body));
  }

  Future<FavListModel> getFavouriteSonglist() async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    final response = await post(
        Uri.parse(
          APIRouter.favSong,
        ),
        body: {
          "user_id": Constants.userModel.userId.toString(),
        });
    print(APIRouter.favSong);
    print("para: user_id: ${Constants.userModel.userId.toString()}");
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      debugPrint(response.body, wrapWidth: 1000);
      return FavListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<LiveRadioModel> getLiveRadio() async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    final response = await get(Uri.parse(APIRouter.liveRadio));
    print(APIRouter.liveRadio);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(response.body);
      return LiveRadioModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<LiveVideoModel> getLiveVideo() async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    final response = await post(Uri.parse(APIRouter.liveVadio), body: {
      "user_id": Constants.userModel.userId.toString(),
    });
    print(APIRouter.liveVadio);
    print("para: user_id: ${Constants.userModel.userId.toString()}");
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print("Live video body");
      print(response.body);
      return LiveVideoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<LikeDisLikeModel> LikeDisLiveVideo(String videoId) async {
    // Map<String, String> headers = {"userid": Constants.userModel.userId.toString(),"token": Constants.userModel.authToken};
    final response = await post(Uri.parse(APIRouter.videoLike), body: {
      "user_id": Constants.userModel.userId.toString(),
      "livevideo_id": videoId
    });
    print(APIRouter.videoLike);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(response.body);
      return LikeDisLikeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<VideoCategoryDataModel> videoCategory() async {
    final response = await get(Uri.parse(APIRouter.videoCategory));
    print(response);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return VideoCategoryDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<VideoCategoryListDataModel> videoCategoryList(String id) async {
    final response = await get(Uri.parse(APIRouter.videoCategoryList + id));

    print("this is video categoruy link ${APIRouter.videoCategoryList + id}");
    print("this is video categoruy link ${response.body}");

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return VideoCategoryListDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<DailyShowModel> dailyShowsApi() async {
    final response = await get(Uri.parse(APIRouter.dailyShows));
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(APIRouter.dailyShows);
      return DailyShowModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch Daily Shows from the REST API');
    }
  }

  Future<EventModelClass> eventApi() async {
    final response = await get(Uri.parse(APIRouter.event));
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(APIRouter.event);
      print(response.body);
      return EventModelClass.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch Event from the REST API');
    }
  }

  Future<TermsAndConditionModelClass> terms() async {
    final response = await get(Uri.parse(APIRouter.terms));
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(APIRouter.event);

      return TermsAndConditionModelClass.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch Event from the REST API');
    }
  }
}
