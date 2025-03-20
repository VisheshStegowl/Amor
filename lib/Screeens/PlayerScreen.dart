import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:gif/gif.dart';

import '../CoreClasses/appBar.dart';
import 'Playlist.dart';

Duration sliderDuration = Duration.zero;
Duration sliderPosition = Duration.zero;
double sliderValue = 0.0;

class PlayerScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  PlayerScreen(
      {Key key,
      @required this.SongName,
      @required this.SongArtist,
      this.SongImg,
      @required this.songType})
      : super(key: key);
  // ignore: non_constant_identifier_names
  final String SongName;
  // ignore: non_constant_identifier_names
  final String SongArtist;
  // ignore: non_constant_identifier_names
  final String SongImg;
  final String songType;
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  GifController controller;
  final PLScreen = PlaylistScreen();
  bool isLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = GifController(vsync: this);
    assetsAudioPlayer.isBuffering.listen((event) {
      if (event) {
        setState(() {
          isLoader = false;
        });
      } else {
        setState(() {
          isLoader = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
          defaultAppBar: AppBar(),
          isMusic: widget.songType == "music",
          isIntro: widget.songType != "music"),
      bottomNavigationBar: const SizedBox.shrink(),
      body: Container(
        height: Utility(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgWithLogo.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: StreamBuilder<RealtimePlayingInfos>(
            stream: assetsAudioPlayer.realtimePlayingInfos,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: appColor,
                      )),
                );
              }
              final playing = snapshot.data;
              Audio myAudio;
              if (snapshot.hasData) {
                if (MySongList.isNotEmpty) {
                  if (playing.current != null) {
                    myAudio = playing.current.audio.audio;
                  }
                }
              }
              return isLoader
                  ? SizedBox(
                      height: Utility(context).height,
                      width: Utility(context).width,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: CoreImage(
                                  height: Utility(context).height * 0.32,
                                  width: Utility(context).width * 0.7,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  url: myAudio.metas == null
                                      ? widget.SongImg
                                      : myAudio.metas.image.path,
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.data == null
                                    ? (widget.SongName ?? "Song Name")
                                    : myAudio.metas == null
                                        ? (widget.SongName ?? "Song Name")
                                        : myAudio.metas.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data == null
                                    ? (widget.SongArtist ?? "Song Artist")
                                    : myAudio.metas == null
                                        ? (widget.SongArtist ?? "Song Artist")
                                        : myAudio.metas.artist,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              SeekBar(
                                duration: playing.duration,
                                position: playing.currentPosition,
                                onChangeEnd: (value) {
                                  assetsAudioPlayer.seek(value);
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: Utility(context).width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    StreamBuilder<RealtimePlayingInfos>(
                                        stream: assetsAudioPlayer
                                            .realtimePlayingInfos,
                                        builder: (context, value) {
                                          return Container(
                                            width: 40,
                                            child: Text(
                                              value.data == null
                                                  ? "00:00"
                                                  : durationToStringTime(value
                                                      .data.currentPosition),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          );
                                        }),
                                    Spacer(),
                                    StreamBuilder<RealtimePlayingInfos>(
                                        stream: assetsAudioPlayer
                                            .realtimePlayingInfos,
                                        builder: (context, value) {
                                          var item = value.data;
                                          return Container(
                                            width: 40,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                item == null
                                                    ? "00:00"
                                                    : durationToStringTime(
                                                        item.duration),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          );
                                        }),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                PLScreen,
                                          ),
                                        ).then((value) {});
                                      },
                                      child: Image.asset(
                                        "assets/images/PlaylistOption.png",
                                        width: 60,
                                        height: 40,
                                        fit: BoxFit.fill,
                                      )),
                                  const Spacer(),
                                  StreamBuilder<RealtimePlayingInfos>(
                                      stream: assetsAudioPlayer
                                          .realtimePlayingInfos,
                                      builder: (context, value) {
                                        var item = value.data;
                                        return InkWell(
                                          onTap: () async {
                                            if ((item.currentPosition
                                                    .inSeconds) !=
                                                0) {
                                              if ((item.currentPosition
                                                      .inSeconds) >=
                                                  10) {
                                                await assetsAudioPlayer.seek(
                                                    Duration(
                                                        seconds: item
                                                                .currentPosition
                                                                .inSeconds -
                                                            10));
                                              } else {
                                                await assetsAudioPlayer.seek(
                                                    const Duration(seconds: 0));
                                              }
                                            }
                                          },
                                          highlightColor: clear,
                                          splashColor: clear,
                                          child: Image.asset(
                                            "assets/images/Play_prev.png",
                                            height: 60,
                                            width: 60,
                                          ),
                                        );
                                      }),
                                  const Spacer(),
                                  StreamBuilder<bool>(
                                    stream: assetsAudioPlayer.isPlaying,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final playing = snapshot.data;

                                        if (!snapshot.data) {
                                          return InkWell(
                                            highlightColor: clear,
                                            splashColor: clear,
                                            onTap: () {
                                              controller.repeat();
                                              assetsAudioPlayer.play();
                                            },
                                            child: Image.asset(
                                              "assets/images/Play.png",
                                              height: 60,
                                              width: 60,
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            highlightColor: clear,
                                            splashColor: clear,
                                            onTap: () {
                                              controller.stop();
                                              assetsAudioPlayer.pause();
                                            },
                                            child: Image.asset(
                                              "assets/images/Pause.png",
                                              height: 60,
                                              width: 60,
                                            ),
                                          );
                                        }
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.all(8.0),
                                          width: 40,
                                          height: 40,
                                          child:
                                              const CircularProgressIndicator(
                                            color: appColor,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  StreamBuilder<RealtimePlayingInfos>(
                                      stream: assetsAudioPlayer
                                          .realtimePlayingInfos,
                                      builder: (context, value) {
                                        var item = value.data;
                                        return InkWell(
                                          onTap: () {
                                            if ((item.currentPosition
                                                    .inSeconds) <
                                                (value
                                                    .data.duration.inSeconds)) {
                                              if ((value.data.duration
                                                          .inSeconds -
                                                      item.currentPosition
                                                          .inSeconds) >
                                                  10) {
                                                assetsAudioPlayer.seek(Duration(
                                                    seconds: item
                                                            .currentPosition
                                                            .inSeconds +
                                                        10));
                                              } else {
                                                assetsAudioPlayer.seek(Duration(
                                                    seconds: value.data.duration
                                                            .inSeconds -
                                                        2));
                                              }
                                            }
                                          },
                                          highlightColor: clear,
                                          splashColor: clear,
                                          child: Image.asset(
                                            "assets/images/Play_next.png",
                                            height: 60,
                                            width: 60,
                                          ),
                                        );
                                      }),
                                  const Spacer(),
                                  StreamBuilder<LoopMode>(
                                    stream: assetsAudioPlayer.loopMode,
                                    builder: (context, snapshot) {
                                      final loopMode =
                                          snapshot.data ?? LoopMode.none;
                                      const icons = [
                                        "assets/images/Play_repeat.png",
                                        "assets/images/PlayRepeatRed.png",
                                        // Icon(Icons.repeat_one, color: Colors.orange),
                                      ];
                                      const cycleModes = [
                                        LoopMode.none,
                                        LoopMode.single,
                                      ];
                                      final index =
                                          cycleModes.indexOf(loopMode);
                                      return InkWell(
                                        highlightColor: clear,
                                        splashColor: clear,
                                        onTap: () {
                                          setState(() {
                                            Constants.isRepeat =
                                                !Constants.isRepeat;
                                          });
                                          assetsAudioPlayer.setLoopMode(
                                              cycleModes[(cycleModes
                                                          .indexOf(loopMode) +
                                                      1) %
                                                  cycleModes.length]);
                                        },
                                        child: Image.asset(
                                          icons[index],
                                          height: 20,
                                          width: 20,
                                          color: index == 0 ? null : appColor,
                                        ),
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Gif(
                                    controller: controller,
                                    autostart: Autostart.loop,
                                    fit: BoxFit.fill,
                                    width: Utility(context).width,
                                    height: 70,
                                    placeholder: (context) => const Center(
                                            child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: appColor,
                                          ),
                                        )),
                                    image: const AssetImage(
                                        "assets/images/GIF.gif")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: appColor,
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
