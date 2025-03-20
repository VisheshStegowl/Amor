import 'dart:async' show Future, StreamSubscription, Timer;
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/CMSModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';
import 'package:gif/gif.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Playlist.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;

class HomeScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  HomeScreen(
      {Key key,
      this.SongName,
      this.SongArtist,
      this.SongImg,
      this.isFirst = false})
      : super(key: key);
  // ignore: non_constant_identifier_names
  String SongName;
  // ignore: non_constant_identifier_names
  String SongArtist;
  // ignore: non_constant_identifier_names
  final String SongImg;
  final bool isFirst;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 0);
  Future<CMSModel> introObj;
  List<ApphomesliderData> introArr;
  int currentIndex = 0;
  Timer timer;
  GifController controller;
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    // TODO: implement initState
    introObj = APIClient().getcms();
    super.initState();

    controller = GifController(vsync: this);
    if (videoController != null) {
      videoController.pause();
    }
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      songCount += 1;
      print(songCount);
      if (songCount == 4) {
        print('showing ad here : $data');
        interstitialAd.show();
        songCount = 0;
      }
    }));
    WidgetsBinding.instance.addObserver(this);
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return cmsData.socialmediaData.first.iosInterstitial;
    } else if (Platform.isAndroid) {
      return cmsData.socialmediaData.first.androidInterstitial;
    }
    return null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    state = state;
    print(state);
    debugPrint(":::::::");
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        assetsAudioPlayer.stop();
        break;
      case AppLifecycleState.inactive:
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  _asyncMethod(int play) async {
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
    assetsAudioPlayer.playlistPlayAtIndex(0);
    // await audioHandler.skipToQueueItem(0);
    // await audioHandler.play();
    Constants.liveRadioPlaying = false;
    isPlay = play;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isIntro: true),
      body: Container(
        height: Utility(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder(
            future: introObj,
            builder: (context, AsyncSnapshot<CMSModel> snap) {
              if (snap.hasData) {
                cmsData = snap.data;
                introArr = snap.data.apphomesliderData;
                if (introArr != null && timer == null) {
                  _addTimer();
                }
                MySongList = [];
                for (var i = 0; i < snap.data.songData.length; i++) {
                  MySongList.add(Audio.network(snap.data.songData[i].song,
                      metas: Metas(
                        image:
                            MetasImage.network(snap.data.songData[i].songImage),
                        artist: snap.data.songData[i].songArtist,
                        title: snap.data.songData[i].songName,
                        id: snap.data.songData[i].songId.toString(),
                      )));
                }
                if (isPlay == 0) {
                  InterstitialAd.load(
                      adUnitId: Platform.isAndroid
                          ? cmsData.socialmediaData.first.androidInterstitial
                          : cmsData.socialmediaData.first.iosInterstitial,
                      request: const AdRequest(),
                      adLoadCallback: InterstitialAdLoadCallback(
                        onAdLoaded: (InterstitialAd ad) {
                          print('$ad loaded');
                          interstitialAd = ad;
                        },
                        onAdFailedToLoad: (LoadAdError error) {
                          print('InterstitialAd failed to load: $error.');
                          interstitialAd = null;
                        },
                      ));
                }
                if (snap.data.songData.isNotEmpty) {
                  if (isPlay == 0) {
                    isPlay = 1;
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                    });
                  }
                  widget.SongName = MySongList[0].metas.title;
                  widget.SongArtist = MySongList[0].metas.artist;
                }
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 20, top: 20),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                )
                              ]),
                          width: (Utility(context).width * 0.9) + 30,
                          height: (Utility(context).width * 0.9),
                          child: introArr.length < 1
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/images/ic_placeholder.png",
                                    fit: BoxFit.contain,
                                    width: (Utility(context).width * 0.9) + 30,
                                    height: (Utility(context).height * 0.23),
                                  ),
                                )
                              : PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: _pageController,
                                  physics: const ClampingScrollPhysics(),
                                  onPageChanged: _onPageChanged,
                                  itemCount: introArr.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        introArr[index].image,
                                        fit: BoxFit.contain,
                                        width:
                                            (Utility(context).width * 0.9) + 30,
                                        height:
                                            (Utility(context).height * 0.23),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      Center(
                        child: introArr.length < 1
                            ? SizedBox.shrink()
                            : SmoothPageIndicator(
                                controller: _pageController,
                                count: introArr.length,
                                axisDirection: Axis.horizontal,
                                effect: const WormEffect(
                                    activeDotColor: pictonBlue,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    dotColor: indicatorColor),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                          stream: assetsAudioPlayer.realtimePlayingInfos,
                          builder: (context,
                              AsyncSnapshot<RealtimePlayingInfos> snapshot) {
                            final playing = snapshot.data;
                            Audio myAudio;
                            if (snapshot.hasData) {
                              if (MySongList.isNotEmpty) {
                                if (playing.current != null) {
                                  myAudio = playing.current.audio
                                      .audio; //find(MySongList, playing.audio.assetAudioPath);
                                }
                              }
                            }
                            return Column(
                              children: [
                                Text(
                                  myAudio == null
                                      ? snapshot.data == null
                                          ? (widget.SongName ?? "Song Name")
                                          : (widget.SongName ?? "Song Name")
                                      : myAudio.metas.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  myAudio == null
                                      ? snapshot.data == null
                                          ? (widget.SongArtist ?? "Song Artist")
                                          : (widget.SongArtist ?? "Song Artist")
                                      : myAudio.metas.artist,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  PlaylistScreen(),
                                            ),
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Image.asset(
                                          "assets/images/PlaylistOption.png",
                                          width: 70,
                                          height: 40,
                                          fit: BoxFit.fill,
                                        )),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        if (!Constants.liveRadioPlaying) {
                                          assetsAudioPlayer.previous();
                                        }
                                      },
                                      highlightColor: clear,
                                      splashColor: clear,
                                      child: Image.asset(
                                        "assets/images/PlayerPrevious.png",
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    StreamBuilder(
                                      stream: assetsAudioPlayer.isPlaying,
                                      builder: (context,
                                          AsyncSnapshot<bool> snapshot) {
                                        if (snapshot.hasData) {
                                          final playing = snapshot.data;
                                          if (playing) {
                                            controller.repeat();
                                            return InkWell(
                                              highlightColor: clear,
                                              splashColor: clear,
                                              onTap: () {
                                                assetsAudioPlayer.pause();
                                                controller.stop();
                                              },
                                              child: Image.asset(
                                                "assets/images/Pause.png",
                                                height: 60,
                                                width: 60,
                                              ),
                                            );
                                          } else {
                                            controller.stop();
                                            return InkWell(
                                              highlightColor: clear,
                                              splashColor: clear,
                                              onTap: () {
                                                if (playing != null) {
                                                  assetsAudioPlayer.play();
                                                  controller.repeat();
                                                } else {
                                                  assetsAudioPlayer
                                                      .playlistPlayAtIndex(0);
                                                }
                                              },
                                              child: Image.asset(
                                                "assets/images/Play.png",
                                                height: 60,
                                                width: 60,
                                              ),
                                            );
                                          }
                                        } else {
                                          return Container(
                                            margin: const EdgeInsets.all(8.0),
                                            width: 25,
                                            height: 25,
                                            child:
                                                const CircularProgressIndicator(
                                              color: appColor,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        if (!Constants.liveRadioPlaying) {
                                          assetsAudioPlayer.next();
                                        }
                                      },
                                      highlightColor: clear,
                                      splashColor: clear,
                                      child: Image.asset(
                                        "assets/images/PlayerNext.png",
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    StreamBuilder<LoopMode>(
                                      stream: assetsAudioPlayer.loopMode,
                                      builder: (context, snapshot) {
                                        final loopMode =
                                            snapshot.data ?? LoopMode.none;
                                        const icons = [
                                          "assets/images/Repeat.png",
                                          "assets/images/repeat_red.png",
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
                                    Spacer(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SeekBar(
                                  duration: playing == null
                                      ? Duration(seconds: 0)
                                      : playing.duration,
                                  position: playing == null
                                      ? Duration(seconds: 0)
                                      : playing.currentPosition,
                                  onChangeEnd: (value) {
                                    assetsAudioPlayer.seek(value);
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
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
                                    Expanded(
                                        child: SizedBox(
                                      width: 0,
                                    )),
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
                                SizedBox(height: 20),
                                Center(
                                    child: Gif(
                                        controller: controller,
                                        autostart: Autostart.no,
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
                                        image: AssetImage(
                                            "assets/images/GIF.gif")))
                              ],
                            );
                          }),
                    ],
                  ),
                );
              }
              return progressView(context);
            }),
      ),
    );
  }

  _addTimer() {
    timer = Timer.periodic(const Duration(seconds: 4), (Timer t) {
      if (currentIndex < introArr.length) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  _onPageChanged(int index) {
    currentIndex = index;
    setState(() {});
  }
}
