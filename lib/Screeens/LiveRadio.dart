import 'dart:io';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/Model/LiveRadioModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';
import 'package:assets_audio_player/src/notification.dart' as notification;
import 'package:gif/gif.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LiveRadio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LiveRadioState();
  }
}

class LiveRadioState extends State<LiveRadio> with TickerProviderStateMixin {
  LiveRadioModel radioObj;
  // ignore: non_constant_identifier_names
  Future<LiveRadioModel> Liveradio;
  bool isLoader = false;
  var isEnabled = true;
  GifController controller;
  AnimationController _animationController;

  int _activeIndex = 0;

  @override
  void initState() {
    if (videoController != null) {
      videoController.pause();
    }
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    Liveradio = APIClient().getLiveRadio();
    _getCms();
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

  _getCms() async {
    cmsData = await APIClient().getcms();

    if (cmsData != null) {
      // cmsData = snap.data;
      // introArr = snap.data.apphomesliderData;
      // if (introArr != null && timer == null) {
      //   _addTimer();
      // }
      MySongList = [];
      for (var i = 0; i < cmsData.songData.length; i++) {
        MySongList.add(Audio.network(cmsData.songData[i].song,
            metas: Metas(
              image: MetasImage.network(cmsData.songData[i].songImage),
              artist: cmsData.songData[i].songArtist,
              title: cmsData.songData[i].songName,
              id: cmsData.songData[i].songId.toString(),
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
      if (cmsData.songData.isNotEmpty) {
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
        // widget.SongName = MySongList[0].metas.title;
        // widget.SongArtist = MySongList[0].metas.artist;
      }
    }
  }

  _asyncMethod() async {
    if (Constants.liveRadioPlaying == false) {
      assetsAudioPlayer.stop();

      Constants.liveRadioPlaying = true;
      playlist = Playlist(audios: MySongList);
      await assetsAudioPlayer.open(
        playlist,
        autoStart: true,
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
            seekBarEnabled: false,
            nextEnabled: false,
            prevEnabled: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(defaultAppBar: AppBar(), isRadio: true),
        body: Container(
            height: Utility(context).height,
            width: Utility(context).width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                // SizedBox(
                //   height: Utility(context).height,
                //   width: Utility(context).width,
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(30, 40, 30, 50),
                //     child: Image.asset("assets/images/radiobg.png"),
                //   ),
                // ),
                SizedBox(
                    height: Utility(context).height,
                    width: Utility(context).width,
                    child: SingleChildScrollView(child: setDesign(context))),
              ],
            )));
  }

  Widget setDesign(BuildContext context) {
    return FutureBuilder<LiveRadioModel>(
        future: Liveradio,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            radioObj = snapshot.data;
            var item = radioObj.data.first;
            MySongList = [
              Audio.network(
                item.url,
                cached: false,
                metas: Metas(
                  image: MetasImage.network(item.logoImage),
                  artist: item.name,
                  title: item.name,
                  id: "radio",
                ),
              )
            ];
            _asyncMethod();
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  // Container(
                  //   width: 250,
                  //   height: 250,
                  //   decoration: BoxDecoration(

                  //       // borderRadius: BorderRadius.horizontal(
                  //       //     left: Radius.elliptical(32, 64),
                  //       //     right: Radius.elliptical(32, 64)),
                  //       borderRadius: BorderRadius.all(Radius.circular(16)),
                  //       image: DecorationImage(
                  //           image: NetworkImage("${item.image.last}"))),
                  // ),

                  Container(
                    width: Utility(context).width * 0.550,
                    height: Utility(context).height * 0.250,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: CarouselSlider.builder(
                      itemCount: item.image.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: item.image[index],
                          errorWidget: (context, url, error) {
                            return progressView(context);
                            // return Text("");
                          },
                          placeholder: (context, url) {
                            return progressView(context);
                          },
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _activeIndex = index;
                          });
                        },
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        aspectRatio: 1 / 1,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //   child: AnimatedSmoothIndicator(
                  //     activeIndex: _activeIndex,
                  //     count: item.image.length,
                  //     effect: const ScaleEffect(
                  //       radius: 6,
                  //       dotWidth: 4,
                  //       dotHeight: 4,
                  //       activeDotColor: white,
                  //       dotColor: Colors.grey,
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: Utility(context).width * 0.02,
                  ),
                  // Center(
                  //   child: Container(
                  //     height: Utility(context).width * 0.75,
                  //     width: Utility(context).width * 0.8,
                  //     // child: radioObj.data.isNotEmpty || radioObj.data != null
                  //     //     ? CoreImage(
                  //     //   url: radioObj.data.first.image,
                  //     //   borderRadius: const BorderRadius.all(Radius.circular(15)),
                  //     //   boxFit: BoxFit.fill,
                  //     // )
                  //     //     : Image.asset("assets/images/ic_placeholder.png"),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 64,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Utility(context).height * 0.020,
                            // width: Utility(context).width,
                            margin: EdgeInsets.only(left: 30),
                            child: const Center(
                              child: FittedBox(
                                  child: Text(
                                "• NOW PLAYING •",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              )),
                            ),
                          ),
                          Container(
                            height: Utility(context).height * 0.020,
                            // width: Utility(context).width,
                            margin: EdgeInsets.only(left: 30),
                            child: Center(
                              child: FittedBox(
                                  child: Text(
                                snapshot.data.data.first.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FadeTransition(
                        opacity: _animationController,
                        child: Container(
                          height: Utility(context).width * 0.030,
                          width: Utility(context).width * 0.030,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: Utility(context).width * 0.02,
                  ),
                  isLoader
                      ? StreamBuilder(
                          stream: assetsAudioPlayer.isPlaying,
                          builder: (context, AsyncSnapshot<bool> snapshot) {
                            final playing = snapshot.data;
                            if (snapshot.hasData) {
                              if (playing) {
                                // controller.repeat(period: Duration());
                                return InkWell(
                                  highlightColor: clear,
                                  splashColor: clear,
                                  onTap: () {
                                    assetsAudioPlayer.pause();
                                    controller.stop();
                                  },
                                  child: Image.asset(
                                    "assets/images/Pause.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                );
                              } else {
                                controller.stop();
                                return InkWell(
                                  highlightColor: clear,
                                  splashColor: clear,
                                  onTap: () {
                                    assetsAudioPlayer.play();
                                    controller.repeat();
                                  },
                                  child: Image.asset(
                                    "assets/images/Play.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 30,
                                height: 30,
                                child: const CircularProgressIndicator(
                                  color: appColor,
                                ),
                              );
                            }
                          },
                        )
                      : const SizedBox(
                          width: 70,
                          height: 70,
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: appColor,
                              ),
                            ),
                          ),
                        ),

                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   decoration: const BoxDecoration(
                  //     color: Color(0x17fbc327),
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //   ),
                  //   child: Text(
                  //     "Dj Angel S RADIO",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  //   width: Utility(context).width,
                  //   child: const Center(
                  //     child: FittedBox(
                  //         child: Text(
                  //       "Powered By Durisimo App Store LLC",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 9),
                  //     )),
                  //   ),
                  // ),
                  SizedBox(
                    height: Utility(context).width * 0.02,
                  ),
                  Container(
                    height: Utility(context).height * 0.650,
                    width: Utility(context).width * 0.8,
                    decoration: BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                      image: NetworkImage(snapshot.data.data[0].logoImage),
                      fit: BoxFit.contain,
                    )),
                  ),
                  SizedBox(
                    height: Utility(context).width * 0.02,
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
                          image: AssetImage("assets/images/GIF.gif")))
                ],
              ),
            );
          }
          return progressView(context);
        });
  }
}
