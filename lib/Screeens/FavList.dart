import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/Model/FavListModel.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';

import '../CoreClasses/MyBottomBar.dart';
import '../CoreClasses/appBar.dart';
import '../Model/CoreResponseModel.dart';
import '../Networking/APIRouter.dart';
import '../Utility/CommanString.dart';
import '../Utility/Constants.dart';
import '../Utility/Dialogs.dart';
import 'PlayerScreen.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;

class FavList extends StatefulWidget {
  const FavList({Key key}) : super(key: key);

  @override
  _FavListState createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  Future<FavListModel> FavSongList;
  bool isLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavSongList = APIClient().getFavouriteSonglist();
  }

  favSongTile(String songImg, String songName, String artistName,
      VoidCallback onDelete) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                CoreImage(
                  url: songImg,
                  height: 60,
                  width: 50,
                  isPlaceHolder: true,
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                // Image.network(songImg,height: 40),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: Utility(context).width - 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songName,
                        maxLines: 2,
                        style: const TextStyle(
                            color: appColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        artistName,
                        maxLines: 2,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
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

  addRemoveFavSongApi(String songID) async {
    var param = {
      "song_id": songID,
      "user_id": Constants.userModel.userId.toString(),
    };
    setState(() {
      isLoader = true;
    });
    CoreResponseModel model = await APIClient().addRemoveFavSong(param);
    setState(() {
      isLoader = false;
    });
    Dialogs.showOSDialog(
        context,
        appName,
        model.message,
        ok,
        () => {
              setState(() {
                FavSongList = APIClient().getFavouriteSonglist();
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
        defaultAppBar: AppBar(),
        isbooking: true,
      ),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: Container(
        width: Utility(context).width,
        height: Utility(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: Utility(context).width,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
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
                        Center(
                            child: Text(
                          "Favorites",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
                FutureBuilder<FavListModel>(
                    future: FavSongList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.status == 200) {
                          if (snapshot.data.data.isEmpty) {
                            return const Expanded(
                                child: Center(
                              child: Text(
                                "No Data Found.",
                                style: TextStyle(color: white),
                              ),
                            ));
                          } else {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
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
                                                        SongName: snapshot
                                                            .data
                                                            .data[index]
                                                            .songName,
                                                        SongArtist: snapshot
                                                            .data
                                                            .data[index]
                                                            .songArtist,
                                                      )));
                                          MySongList = [];
                                          for (var i = 0;
                                              i < snapshot.data.data.length;
                                              i++) {
                                            MySongList.add(Audio.network(
                                                snapshot.data.data[i].song,
                                                metas: Metas(
                                                  image: MetasImage.network(
                                                      snapshot.data.data[i]
                                                          .songImage),
                                                  artist: snapshot
                                                      .data.data[i].songArtist,
                                                  title: snapshot
                                                      .data.data[i].songName,
                                                  id: snapshot
                                                      .data.data[i].songId
                                                      .toString(),
                                                ),
                                                cached: false));
                                          }
                                          playlist = Playlist(
                                            audios: MySongList,
                                          );
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
                                        child: favSongTile(
                                            snapshot.data.data[index].songImage,
                                            snapshot.data.data[index].songName,
                                            snapshot.data.data[index]
                                                .songArtist, () {
                                          addRemoveFavSongApi(snapshot
                                              .data.data[index].songId
                                              .toString());
                                        }),
                                      );
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
                      return Expanded(
                        child: const Center(
                          child: CircularProgressIndicator(color: appColor),
                        ),
                      );
                    })
              ],
            ),
            isLoader
                ? SizedBox(
                    height: Utility(context).height,
                    child: const Center(
                      child: CircularProgressIndicator(color: appColor),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
