import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/SearchListModel.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/CoreClasses/PlayListDialog.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/Cells/SongListCell.dart';
import 'package:amor_93_7_fm/Screeens/PlayerScreen.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;

import '../Utility/CommanString.dart';
import '../Utility/Dialogs.dart';

// ignore: must_be_immutable
class SearchList extends StatefulWidget {
  SearchList({Key key, this.searchText}) : super(key: key);
  String searchText;
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Future<SearchListModel> SongsList;
  List<SongData> SearchSongsList = List<SongData>.empty(growable: true);
  int page = 1;
  int lastPage = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongsList = APIClient().getSearchList(widget.searchText, page);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (page != lastPage) {
          setState(() {
            page = page + 1;
            SongsList = APIClient().getSearchList(widget.searchText, page);
          });
        }
      }
    });
    if (videoController != null) {
      videoController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isIntro: true),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: Utility(context).width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/back.png",
                            color: Colors.white,
                            width: 30,
                            height: 20,
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Image.asset("assets/images/Search.png"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController()
                                    ..text = widget.searchText,
                                  onSubmitted: (text) {
                                    setState(() {
                                      widget.searchText = text;
                                      SongsList =
                                          APIClient().getSearchList(text, 1);
                                    });
                                  },
                                  textInputAction: TextInputAction.search,
                                  decoration: const InputDecoration(
                                      hintText: 'Search',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(4),
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                    "assets/images/SearchHeart.png"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<SearchListModel>(
                  future: SongsList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.status);
                      if (snapshot.data.status == 200) {
                        if (snapshot.data.data.length == 0) {
                          return Expanded(
                              child: Container(
                                  child: const Center(
                            child: Text(
                              "No Data Found",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )));
                        } else {
                          lastPage = snapshot.data.lastPage;
                          if (snapshot.data.currentPage == 1) {
                            SearchSongsList = snapshot.data.data;
                          } else {
                            for (var i in snapshot.data.data) {
                              SearchSongsList.add(i);
                            }
                          }
                          MySongList = [];
                          for (var i = 0; i < SearchSongsList.length; i++) {
                            MySongList.add(
                                Audio.network(SearchSongsList[i].song,
                                    metas: Metas(
                                      image: MetasImage.network(
                                          SearchSongsList[i].songImage),
                                      artist: SearchSongsList[i].songArtist,
                                      title: SearchSongsList[i].songName,
                                      id: SearchSongsList[i].songId.toString(),
                                    ),
                                    cached: false));
                          }
                          return Expanded(
                            child: ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount: SearchSongsList.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          await assetsAudioPlayer.stop();
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      PlayerScreen(
                                                        songType: "search",
                                                        SongImg:
                                                            SearchSongsList[
                                                                    index]
                                                                .songImage,
                                                        SongName:
                                                            SearchSongsList[
                                                                    index]
                                                                .songName,
                                                        SongArtist:
                                                            SearchSongsList[
                                                                    index]
                                                                .songArtist,
                                                      )));
                                          print(
                                              "Songs count ${MySongList.length}");
                                          print(
                                              SearchSongsList[index].songImage);
                                          playlist =
                                              Playlist(audios: MySongList);
                                          await assetsAudioPlayer.open(
                                            playlist,
                                            autoStart: false,
                                            showNotification: true,
                                            notificationSettings: notification
                                                .NotificationSettings(
                                                    customNextAction:
                                                        (player) async {
                                                      await assetsAudioPlayer
                                                          .next();
                                                    },
                                                    customPrevAction:
                                                        (player) async {
                                                      await assetsAudioPlayer
                                                          .previous();
                                                    },
                                                    playPauseEnabled: true,
                                                    stopEnabled: false,
                                                    seekBarEnabled: true,
                                                    nextEnabled: true,
                                                    prevEnabled: true),
                                          );
                                          assetsAudioPlayer
                                              .playlistPlayAtIndex(index);
                                          Constants.liveRadioPlaying = false;
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      splashColor: appColor,
                                      highlightColor: appColor,
                                      focusColor: appColor,
                                      hoverColor: appColor,
                                      child: SongListCell(
                                          SongID: SearchSongsList[index]
                                              .songId
                                              .toString(),
                                          ArtistName:
                                              SearchSongsList[index].songArtist,
                                          SongDuration: SearchSongsList[index]
                                              .songDuration,
                                          SongName:
                                              SearchSongsList[index].songName,
                                          onAddPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PlaylistDialog(
                                                    isFav: SearchSongsList[
                                                                index]
                                                            .favouritesStatus
                                                        ? 0
                                                        : 2,
                                                    isPlaylist: false,
                                                    songID:
                                                        SearchSongsList[index]
                                                            .songId
                                                            .toString(),
                                                    playlistID: "",
                                                    favCall: () => {
                                                      if (SearchSongsList[index]
                                                          .favouritesStatus)
                                                        {
                                                          // Navigator.pop(context),
                                                          Dialogs.showOSDialog(
                                                              context,
                                                              appName,
                                                              "Song is already added in favourite list",
                                                              "Ok", () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                        },
                                                      setState(() {
                                                        SearchSongsList
                                                            .removeRange(
                                                                0,
                                                                SearchSongsList
                                                                    .length);
                                                        page = 1;
                                                        SongsList = APIClient()
                                                            .getSearchList(
                                                                widget
                                                                    .searchText,
                                                                page);
                                                      })
                                                    },
                                                    playListCallback: () => {
                                                      _addToPlaylist(
                                                          "${SearchSongsList[index].songId}"),
                                                    },
                                                  );
                                                });
                                          }),
                                    ),
                                  );
                                }),
                          );
                        }
                      } else {
                        return Text(
                          snapshot.data.message,
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    } else if (snapshot.hasError) {
                      print("${snapshot.error}");
                      return Text(
                        "${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                    // By default, show a loading spinner.
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: appColor,
                          semanticsLabel: 'Loading',
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      page = page + 1;
    });
    SongsList = APIClient().getSearchList(widget.searchText, page);
  }

  _addToPlaylist(String songID) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return AddPlayListDialog(
              createCallback: () => {_createPlaylist(songID)},
              addExistingCallback: () => {_addToExisting(songID)},
            );
          });
    });
  }

  _addToExisting(String songID) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return ExistingPlayListDialog(
              songID: songID,
            );
          });
    });
  }

  _createPlaylist(String songID) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) {
            return CreatePlayListDialog(
              songID: songID,
              callBack: () {
                Navigator.pop(context);
                setState(() {});
              },
            );
          });
    });
  }
}
