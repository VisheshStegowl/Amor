import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Screeens/Playlist.dart';

class MyBottomBar extends StatefulWidget implements PreferredSizeWidget {
  MyBottomBar({Key key, @required this.appBar}) : super(key: key);
  final AppBar appBar;

  @override
  _MyBottomBarState createState() => _MyBottomBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      new Size.fromHeight(widget.appBar.preferredSize.height);
  BannerAd _bannerAd;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    print("here is the height of bottom ${preferredSize.height}");
    loadAd();
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return cmsData.socialmediaData.first
          .iosKey; //'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return cmsData.socialmediaData.first
          .androidKey; //'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  void loadAd() {
    BannerAd(
      adUnitId: getBannerAdUnitId(),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      color: Colors.black,
      child: Column(
        children: [
          StreamBuilder(
              stream: assetsAudioPlayer.realtimePlayingInfos,
              builder: (context, AsyncSnapshot<RealtimePlayingInfos> snapshot) {
                final playing = snapshot.data;
                Audio myAudio;
                // print(MySongList);
                if (snapshot.hasData) {
                  if (playing.current != null) {
                    myAudio = playing.current.audio.audio;
                  }
                }
                return Column(children: [
                  SeekBar(
                    duration: playing != null
                        ? playing.duration
                        : Duration(seconds: 0),
                    position: playing != null
                        ? playing.currentPosition
                        : Duration(seconds: 0),
                    onChangeEnd: (value) {
                      assetsAudioPlayer.seek(value);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      StreamBuilder<RealtimePlayingInfos>(
                          stream: assetsAudioPlayer.realtimePlayingInfos,
                          builder: (context, value) {
                            return Container(
                              width: 40,
                              child: Text(
                                value.data == null
                                    ? "00:00"
                                    : durationToStringTime(
                                        value.data.currentPosition),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            );
                          }),
                      Expanded(
                          child: SizedBox(
                        width: 0,
                      )),
                      StreamBuilder<RealtimePlayingInfos>(
                          stream: assetsAudioPlayer.realtimePlayingInfos,
                          builder: (context, value) {
                            var item = value.data;
                            return Container(
                              width: 40,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  item == null
                                      ? "00:00"
                                      : durationToStringTime(item.duration),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: Utility(context).width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Center(
                        child: Text(
                          myAudio == null ? ("Song Name") : myAudio.metas.title,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: Utility(context).width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Center(
                        child: Text(
                          myAudio == null
                              ? ("Song Artist")
                              : myAudio.metas.artist,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ),
                ]);
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => PlaylistScreen(),
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
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Spacer(),
                  StreamBuilder(
                    stream: assetsAudioPlayer.isPlaying,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      final playing = snapshot.data;
                      if (snapshot.hasData) {
                        if (playing) {
                          return InkWell(
                            highlightColor: clear,
                            splashColor: clear,
                            onTap: () {
                              assetsAudioPlayer.pause();
                            },
                            child: Image.asset(
                              "assets/images/Pause.png",
                              height: 50,
                              width: 50,
                            ),
                          );
                        } else {
                          return InkWell(
                            highlightColor: clear,
                            splashColor: clear,
                            onTap: () {
                              assetsAudioPlayer.play();
                            },
                            child: Image.asset(
                              "assets/images/Play.png",
                              height: 50,
                              width: 50,
                            ),
                          );
                        }
                      } else {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 35,
                          height: 35,
                          child: const CircularProgressIndicator(
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
                        await assetsAudioPlayer.next();
                      }
                    },
                    highlightColor: clear,
                    splashColor: clear,
                    child: Image.asset(
                      "assets/images/PlayerNext.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Spacer(),
                  StreamBuilder<LoopMode>(
                    stream: assetsAudioPlayer.loopMode,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.none;
                      const icons = [
                        "assets/images/Repeat.png",
                        "assets/images/repeat_red.png",
                        // Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.none,
                        LoopMode.single,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return InkWell(
                        highlightColor: clear,
                        splashColor: clear,
                        onTap: () {
                          assetsAudioPlayer.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                        child: Image.asset(
                          icons[index],
                          height: 30,
                          width: 30,
                          color: index == 0 ? null : appColor,
                        ),
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
              height: 60,
              width: Utility(context).width,
              color: Colors.black,
              child: _bannerAd != null
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: SizedBox(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
        ],
      ),
    );
  }
}
