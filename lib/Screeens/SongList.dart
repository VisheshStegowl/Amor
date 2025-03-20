import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/CoreClasses/PlayListDialog.dart';
import 'package:amor_93_7_fm/Model/SongListModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/Cells/SongListCell.dart';
import 'package:amor_93_7_fm/Screeens/PlayerScreen.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'Cells/SongCategoryCell.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;

// ignore: must_be_immutable
class SongList extends StatefulWidget {
  SongList(
      // ignore: non_constant_identifier_names
      {Key key,
      @required this.songCategoryId,
      this.CatTitle,
      this.CatImg})
      : super(key: key);
  final int songCategoryId;
  // ignore: non_constant_identifier_names
  final String CatTitle;
  // ignore: non_constant_identifier_names
  final String CatImg;
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<SongData> songs = [];
  Future<SongListModel> SongsList;
  int page = 1;
  int lastPage = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongsList = APIClient().getSongList({
      "songcategory_id": widget.songCategoryId.toString(),
      "user_id": Constants.userModel.userId.toString()
    }, "$page");
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (page != lastPage) {
          setState(() {
            page = page + 1;
            SongsList = APIClient().getSongList({
              "songcategory_id": widget.songCategoryId.toString(),
              "user_id": Constants.userModel.userId.toString()
            }, "$page");
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
      appBar: MyAppBar(defaultAppBar: AppBar(), isMusic: true),
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
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      top: 20,
                      bottom: 20,
                      right: Utility(context).width - 50),
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
              ),
              Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: SongCategoryCell(
                    title: widget.CatTitle,
                    img: widget.CatImg,
                    onPress: () {},
                  )),
              FutureBuilder<SongListModel>(
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
                            songs = snapshot.data.data;
                          } else {
                            for (var i in snapshot.data.data) {
                              songs.add(i);
                            }
                          }
                          MySongList = [];
                          for (var i in songs) {
                            MySongList.add(Audio.network(i.song,
                                metas: Metas(
                                  image: MetasImage.network(i.songImage),
                                  artist: i.songArtist,
                                  title: i.songName,
                                  id: i.songId.toString(),
                                ),
                                cached: false));
                          }
                          return Expanded(
                            child: ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount: songs.length,
                                itemBuilder: (context, index) {
                                  if (index >= songs.length) {
                                    return SizedBox.shrink();
                                  }
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
                                                        songType: "music",
                                                        SongImg: songs[index]
                                                            .songImage,
                                                        SongName: songs[index]
                                                            .songName,
                                                        SongArtist: songs[index]
                                                            .songArtist,
                                                      )));
                                          // print("Songs count ${MySongList.length}");
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
                                          setState(() {
                                            Constants.liveRadioPlaying = false;
                                          });
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      splashColor: appColor,
                                      highlightColor: appColor,
                                      focusColor: appColor,
                                      hoverColor: appColor,
                                      child: SongListCell(
                                          SongID:
                                              songs[index].songId.toString(),
                                          ArtistName: songs[index].songArtist,
                                          SongDuration:
                                              songs[index].songDuration,
                                          SongName: songs[index].songName,
                                          onAddPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PlaylistDialog(
                                                    isFav: songs[index]
                                                            .favouritesStatus
                                                        ? 0
                                                        : 1,
                                                    isPlaylist: false,
                                                    songID: songs[index]
                                                        .songId
                                                        .toString(),
                                                    playlistID: "",
                                                    favCall: () => {
                                                      if (songs[index]
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
                                                        SongsList = APIClient()
                                                            .getSongList({
                                                          "songcategory_id":
                                                              widget
                                                                  .songCategoryId
                                                                  .toString(),
                                                          "user_id": Constants
                                                              .userModel.userId
                                                              .toString()
                                                        }, "$page");
                                                      })
                                                    },
                                                    playListCallback: () => {
                                                      _addToPlaylist(
                                                          "${songs[index].songId}"),
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
                // setState(() {
                //   _controller.position.jumpTo(0);
                //   songs = [];
                //   SongsList = APIClient().getSongList({"songcategory_id": widget.songCategoryId.toString(),"user_id":Constants.userModel.userId.toString()}, "$page");
                // });
              },
            );
          });
    });
  }
}

UpdatePlaylistPlay() async {
  playlist = Playlist(audios: MySongList);
  await assetsAudioPlayer.open(
    playlist,
    autoStart: false,
    showNotification: true,
    notificationSettings: notification.NotificationSettings(
        customNextAction: (player) async {
          await assetsAudioPlayer.next();
        },
        customPrevAction: (player) async {
          await assetsAudioPlayer.previous();
        },
        playPauseEnabled: true,
        stopEnabled: false,
        seekBarEnabled: true),
  );
}
