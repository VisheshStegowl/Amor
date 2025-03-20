import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyButton.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/Model/LikeDisLikeModel.dart';
import 'package:amor_93_7_fm/Model/LiveVideoModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../Model/CMSModel.dart';

class LiveVideoVC extends StatefulWidget {
  const LiveVideoVC({Key key}) : super(key: key);

  @override
  _LiveVideoVCState createState() => _LiveVideoVCState();
}

class _LiveVideoVCState extends State<LiveVideoVC> with WidgetsBindingObserver {
  String msg;
  final txt = TextEditingController();
  LiveVideoModel liveVideoObj = LiveVideoModel();
  DatabaseReference _messagesRef;
  StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool isLoader = false;
  bool isState = false;
  bool isOrientation = false;
  bool isKeyBord = true;
  String id;
  Timer timer;
  String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String time = DateFormat('h:mm a').format(DateTime.now());
  ScrollController _scrollController = new ScrollController();
  String _kTestKey4 = 'time';
  String _kTestKey5 = 'commentDate';
  String _kTestKey = 'comment';
  String _kTestKey1 = 'commentByName';
  String _kTestKey2 = 'commentImageURL';
  String _kTestKey3 = 'type';
  String _kTestValue3 = 'user';
  bool isShowICon = true;

  void initState() {
    final FirebaseDatabase database =
        FirebaseDatabase.instanceFor(app: Firebase.app());
    _messagesRef = FirebaseDatabase.instance.ref('User');

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((DatabaseEvent event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final FirebaseException error = o as FirebaseException;
      print('Error: ${error.code} ${error.message}');
    });
    Constants.isShowIcons = true;
    getLiveVideoDetails();
    startTimer();
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        if (isShowICon) {
          isShowICon = false;
        }
      });
    });
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  getLiveVideoDetails() async {
    setState(() {
      isLoader = true;
    });
    liveVideoObj = await APIClient().getLiveVideo();
    print(liveVideoObj.message);
    await assetsAudioPlayer.pause();
    configurePlayer(liveVideoObj.data);
    setState(() {
      isLoader = false;
    });
    // sponserSliderAPI();
  }

  configurePlayer(List<LiveVideo> videoData) {
    videoController = VideoPlayerController.network(videoData.first.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        print("video intialized");
        setState(() {
          Constants.liveRadioPlaying = false;
        });
        videoController.play();
      });

    WidgetsBinding.instance.addObserver(this);
  }

  void startTimer() {
    final duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (Timer timer) {
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
        if (isKeyBord == true) {
          isKeyBord = false;
          print("Keyboard is visible.");
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {});
          });
        }
        //Keyboard is visible.
      } else {
        if (isKeyBord == false) {
          isKeyBord = true;
          print("Keyboard is not visible.");
          Future.delayed(Duration(milliseconds: 1000), () {
            setState(() {});
          });
        }
        //Keyboard is not visible.
      }
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        if (isOrientation == true) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              isOrientation = false;
              print("testing");
            });
          });
        }

        // is portrait
      } else {
        isOrientation = true;
        // is landscape
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    videoController.dispose();
    // _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    FocusScope.of(context).unfocus();
    if (msg == null || msg == "") {
      NormalAlert.showAlertDialog(
          context, "Validation", "Please write a message");
    } else {
      setState(() {
        _messagesRef.push().set(<String, String>{
          _kTestKey: '$msg',
          _kTestKey1: 'user',
          _kTestKey2: 'https://amor937.com/amor937/assets/img/avtar.png',
          _kTestKey3: '$_kTestValue3',
          _kTestKey4: '$time',
          _kTestKey5: '$date'
        });
        msg = "";
        txt.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    return WillPopScope(
      onWillPop: () {
        videoController.pause();
        videoController.dispose();
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(isStream: true, defaultAppBar: AppBar()),
        body: Container(
          height: Utility(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Container(child: setDesign(context)),
              isLoader ? progressView(context) : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget setDesign(BuildContext context) {
    List<SponsorbannerData> sponserObj =
        cmsData != null ? cmsData.sponsorbannerData : null;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: Utility(context).height * 0.3,
              color: Colors.black,
              child: liveVideoObj.data != null
                  ? Container(
                      height: 180,
                      child: videoController.value != null
                          ? videoController.value.isInitialized
                              ? VideoPlayer(videoController)
                              : Container(
                                  height: 180,
                                  width: Utility(context).width,
                                  child: Center(
                                      child: Image.asset(
                                          "assets/images/offline.png")),
                                )
                          : Container(
                              height: 180,
                              width: Utility(context).width,
                              child: Center(
                                  child:
                                      Image.asset("assets/images/offline.png")),
                            ),
                    )
                  : Container(
                      height: 180,
                      width: Utility(context).width,
                      child: Center(
                          child:
                              Image.asset("assets/images/ic_placeholder.png")),
                    ),
            ),
            InkWell(
              onTap: () {
                print("icons are visible $isShowICon");
                setState(() {
                  isShowICon = !isShowICon;
                });
                Future.delayed(Duration(seconds: 5), () {
                  setState(() {
                    if (isShowICon) {
                      isShowICon = false;
                    }
                  });
                });
              },
              child: Container(
                height: Utility(context).height * 0.3,
                width: Utility(context).width,
                child: isShowICon
                    ? Container(
                        height: Utility(context).height * 0.3,
                        width: Utility(context).width,
                        child: Center(
                          child: InkWell(
                              onTap: () => {
                                    if (videoController.value.isPlaying)
                                      {videoController.pause()}
                                    else
                                      {videoController.play()},
                                    setState(() {})
                                  },
                              child: Icon(
                                  videoController == null
                                      ? Icons.play_arrow_outlined
                                      : (videoController.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow_outlined),
                                  color: white,
                                  size: 40.0)),
                        ),
                      )
                    : Container(
                        height: Utility(context).height * 0.3,
                        width: Utility(context).width,
                      ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => {likeDisLikeVideo()},
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_like.png',
                        color: liveVideoObj.data == null
                            ? Colors.white
                            : (liveVideoObj.data[0].likeStatus == true
                                ? appColor
                                : Colors.white),
                        width: 27,
                        height: 22,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        liveVideoObj.data == null
                            ? "0"
                            : liveVideoObj.data.first.likeCount.toString(),
                        // "Like",
                        style: TextStyle(fontSize: 14, color: white),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => {
                    Share.share(
                        liveVideoObj.data == null
                            ? ""
                            : liveVideoObj.data.first.url,
                        subject: 'App Name: By ${appName}')
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.white,
        ),
        Container(
          height: 70,
          child: PageView.builder(
              itemCount: sponserObj == null ? 0 : sponserObj.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => {
                    launchURL(sponserObj[index].url != null
                        ? sponserObj[index].url
                        : "")
                  },
                  child: CoreImage(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    url: sponserObj[index].image,
                    height: 50,
                    boxFit: BoxFit.contain,
                    isPlaceHolder: false,
                  ),
                );
              }),
        ),
        Flexible(
          child: FirebaseAnimatedList(
            controller: _scrollController,
            key: ValueKey<bool>(false),
            query: _messagesRef,
            shrinkWrap: false,
            reverse: false,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              if (snapshot.value == null) {
                return Container();
              }
              if ((snapshot.value as Map)['type'].toString().toLowerCase() ==
                  'user') {
                return senderCell(context, snapshot);
              }
              return receiveCell(context, snapshot);
            },
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          controller: txt,
                          onChanged: ((value) {
                            setState(() {
                              msg = value;
                            });
                          }),
                          onSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              isDense: true,
                              hintText: 'Post A Message',
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                        InkWell(
                          onTap: _increment,
                          child: CoreButton(
                            title: 'post'.toUpperCase(),
                            color: appColor,
                            width: 80,
                            height: 35,
                            radius: 15,
                            titleColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )),
            )),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget senderCell(BuildContext context, DataSnapshot data) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CoreImage(
                    url: (data.value as Map)['commentImageURL'].toString(),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    height: 40,
                    width: 40,
                    boxFit: BoxFit.fitWidth,
                    isPlaceHolder: true,
                  ),
                  Text(
                    (data.value as Map)['commentByName'].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  (data.value as Map)['comment'].toString(),
                  maxLines: 100,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 115,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                    Text(
                      (data.value as Map)['time'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              color: appGray.withOpacity(0.3),
            )),
      ],
    );
  }

  Widget receiveCell(BuildContext context, DataSnapshot data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Text(
                (data.value as Map)['time'].toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  child: Text(
                    (data.value as Map)['comment'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 100,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CoreImage(
                  url: (data.value as Map)['commentImageURL'].toString(),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  height: 40,
                  width: 40,
                  boxFit: BoxFit.fitWidth,
                  isPlaceHolder: true,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 1,
            color: appGray.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  void likeDisLikeVideo() async {
    setState(() {
      isLoader = true;
    });
    LikeDisLikeModel model = await APIClient()
        .LikeDisLiveVideo(liveVideoObj.data[0].livevideoId.toString());
    liveVideoObj = await APIClient().getLiveVideo();

    if (model.status == 200) {
      setState(() {
        isLoader = false;
      });
      // NormalAlert.showAlertDialog(context, "Success", model.message);
    } else {
      setState(() {
        isLoader = false;
      });
      NormalAlert.showAlertDialog(context, "Success", model.message);
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      NormalAlert.showAlertDialog(context, "Error", "Could not launch $url");
    }
  }
}
