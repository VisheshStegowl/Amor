import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/CoreResponseModel.dart';
import 'package:amor_93_7_fm/Model/PlaylistModel.dart';
import 'package:amor_93_7_fm/Model/PlaylistSongModel.dart';
import 'package:amor_93_7_fm/Screeens/SearchScreen.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/Model/SongListModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:sizer/sizer.dart';
import 'MenuList.dart';
import 'PlayerScreen.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;

// ignore: must_be_immutable
class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<SongData> songs = [];
  Future<PlaylistModel> PlaylistList;
  bool isLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlaylistList = APIClient()
        .getPlaylist({"user_id": Constants.userModel.userId.toString()}, "1");
    if (videoController != null) {
      videoController.pause();
    }
  }

  removePlaylist(String PLid) async {
    var param = {
      "user_id": Constants.userModel.userId.toString(),
      "playlist_id": PLid,
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model =
        await APIClient().createRemovePlaylist(param, "remove");
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(context, appName, model.message, ok, () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => PlaylistScreen(),
        ),
      ).then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Hey I'm called");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
        defaultAppBar: AppBar(),
        isbooking: true,
      ),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: Sizer(builder: (context, orientation, deviceType) {
        return Container(
          width: 100.w,
          height: 100.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              isLoader
                  ? SizedBox(
                      height: 100.h,
                      child: const Center(
                        child: CircularProgressIndicator(color: appColor),
                      ),
                    )
                  : const SizedBox.shrink(),
              FutureBuilder<PlaylistModel>(
                  future: PlaylistList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == 200) {
                        if (snapshot.data.data.isEmpty) {
                          // print(snapshot.data.data.length);
                          return SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  "assets/images/ic_logo.png",
                                  height: 40.h,
                                  width: 250,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 10, bottom: 30),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Image.asset(
                                              "assets/images/Search.png"),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(child: searchTextField()),
                                        // SizedBox.expand(),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Image.asset(
                                              "assets/images/SearchHeart.png"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                MenuList()),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      width: 100.w / 1.8,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          // border: Border.all(
                                          //     width: 5,
                                          //     color: Color(0xff363636)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/AddPL.png",
                                            height: 40,
                                            color: appColor,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "ADD MUSIC TO PLAYLIST",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  snapshot.data.data.length + 1, (index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        top: 30,
                                        bottom: 30),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Image.asset(
                                                "assets/images/Search.png"),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: searchTextField(),
                                          ),
                                          // SizedBox.expand(),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(
                                                "assets/images/SearchHeart.png"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return playlistTile(
                                    plID: snapshot
                                        .data.data[index - 1].playlistId
                                        .toString(),
                                    plName: snapshot.data.data[index - 1].name,
                                    onDelete: () {
                                      Dialogs.showOSDialog(
                                          context,
                                          appName,
                                          areyousuredeletePlaylist,
                                          "Ok",
                                          () {
                                            removePlaylist(snapshot
                                                .data.data[index - 1].playlistId
                                                .toString());
                                          },
                                          secondButtonText: "Cancel",
                                          secondCallback: () {
                                            setState(() {});
                                          });
                                    },
                                    totalsong: snapshot
                                        .data.data[index - 1].total_song
                                        .toString(),
                                  );
                                }
                              }),
                            ),
                          );
                        }
                      } else {
                        return Text(
                          snapshot.data.message,
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text(
                        "${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: appColor,
                      ),
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }
}

playlistSongTile(
    String songImg, String songName, String artistName, VoidCallback onDelete) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        Container(
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Image.network(songImg, height: 40),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songName,
                    style: const TextStyle(
                        color: appColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    artistName,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: onDelete,
                child: Image.asset(
                  "assets/images/ic_delete.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  color: appColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

class playlistTile extends StatefulWidget {
  const playlistTile({
    Key key,
    this.plName,
    this.plID,
    this.onDelete,
    this.totalsong,
  }) : super(key: key);

  final String plName;
  final String totalsong;
  final String plID;
  final VoidCallback onDelete;
  @override
  State<playlistTile> createState() => _playlistTileState();
}

class _playlistTileState extends State<playlistTile> {
  bool isOpen = false;
  Future<PlaylistSongModel> PlaylistSongsList;
  bool isLoader = false;
  var totalSong = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlaylistSongsList = APIClient().getPlaylistSongList({
      "user_id": Constants.userModel.userId.toString(),
      "playlist_id": widget.plID
    }, "1");
  }

  void removeSongToPlaylist(String PlID) async {
    var param = {
      // "playlist_id": widget.playlistID,
      "playlistsong_id": PlID,
      "user_id": Constants.userModel.userId.toString(),
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model =
        await APIClient().addSongToPlaylist(param, "remove");
    PlaylistSongsList = APIClient().getPlaylistSongList({
      "user_id": Constants.userModel.userId.toString(),
      "playlist_id": widget.plID
    }, "1");
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context, appName, model.message, ok, () => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 72,
                padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          decoration: const BoxDecoration(
                            color: Color(0x19FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            widget.plName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          decoration: const BoxDecoration(
                            color: Color(0x43FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: FittedBox(
                              child: Text(
                            "${widget.totalsong ?? totalSong} TRACKS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                          )),
                        )
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Image.asset(
                        "assets/images/DropDown.png",
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                        color: appColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: const BoxDecoration(
                          color: Color(0x45FFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          isOpen == true ? "CLOSE LIST" : "OPEN LIST",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: widget.onDelete,
                      child: Image.asset(
                        "assets/images/ic_delete.png",
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                        color: appColor,
                      ),
                    ),
                  ],
                ),
              ),
              isOpen
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        color: Colors.black87,
                        height: 8,
                      ),
                    )
                  : const SizedBox.shrink(),
              FutureBuilder<PlaylistSongModel>(
                  future: PlaylistSongsList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.status == 200) {
                        if (snapshot.data.data.isEmpty) {
                          print(snapshot.data.data.length);
                          return SizedBox.shrink();
                        } else {
                          totalSong = snapshot.data.data.length;
                          MySongList = [];
                          for (var i = 0; i < snapshot.data.data.length; i++) {
                            MySongList.add(
                                Audio.network(snapshot.data.data[i].song,
                                    metas: Metas(
                                      image: MetasImage.network(
                                          snapshot.data.data[i].songImage),
                                      artist: snapshot.data.data[i].songArtist,
                                      title: snapshot.data.data[i].songName,
                                      id: snapshot.data.data[i].songId
                                          .toString(),
                                    ),
                                    cached: false));
                          }
                          return isOpen
                              ? Column(
                                  children: List.generate(
                                      snapshot.data.data.length, (index) {
                                    return InkWell(
                                      onTap: () async {
                                        await assetsAudioPlayer.stop();
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    PlayerScreen(
                                                      songType: "PL",
                                                      SongImg: snapshot
                                                          .data
                                                          .data[index]
                                                          .songImage,
                                                      SongName: snapshot.data
                                                          .data[index].songName,
                                                      SongArtist: snapshot
                                                          .data
                                                          .data[index]
                                                          .songArtist,
                                                    )));
                                        playlist = Playlist(
                                          audios: MySongList,
                                        );
                                        await assetsAudioPlayer.open(
                                          playlist,
                                          autoStart: false,
                                          showNotification: true,
                                          notificationSettings:
                                              notification.NotificationSettings(
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
                                                  seekBarEnabled: true),
                                        );
                                        assetsAudioPlayer
                                            .playlistPlayAtIndex(index);
                                        Constants.liveRadioPlaying = false;
                                      },
                                      splashColor: appColor,
                                      highlightColor: appColor,
                                      focusColor: appColor,
                                      hoverColor: appColor,
                                      child: playlistSongTile(
                                          snapshot.data.data[index].songImage,
                                          snapshot.data.data[index].songName,
                                          snapshot.data.data[index].songArtist,
                                          () {
                                        removeSongToPlaylist(snapshot
                                            .data.data[index].playlistsongId
                                            .toString());
                                      }),
                                    );
                                  }),
                                )
                              : const SizedBox(
                                  height: 10,
                                );
                        }
                      } else {
                        return Text(
                          snapshot.data.message,
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text(
                        "${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                    return isOpen
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: appColor,
                            ),
                          )
                        : const SizedBox(
                            height: 10,
                          );
                  })
            ],
          ),
          isLoader
              ? SizedBox(
                  height: 100.h,
                  child: const Center(
                    child: CircularProgressIndicator(color: appColor),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class searchTextField extends StatefulWidget {
  const searchTextField({Key key}) : super(key: key);

  @override
  State<searchTextField> createState() => _searchTextFieldState();
}

class _searchTextFieldState extends State<searchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (text) {
        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => SearchList(
                    searchText: text,
                  )),
        ).then((value) {
          setState(() {});
        });
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: 'Search',
          isDense: true,
          contentPadding: EdgeInsets.all(4),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          enabledBorder: InputBorder.none),
    );
  }
}
