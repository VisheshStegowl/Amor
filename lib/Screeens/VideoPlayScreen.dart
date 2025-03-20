import 'package:amor_93_7_fm/CoreClasses/DescriptionWidget.dart';
import 'package:amor_93_7_fm/CoreClasses/VideoPlayer.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';

class VideoPlayScreen extends StatelessWidget {
  final String videoUrl;
  final String discription;
  final String videoTitle;
  const VideoPlayScreen(
      {Key key, this.videoUrl, this.discription, this.videoTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assetsAudioPlayer.pause();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isVideo: true),
      body: SafeArea(
        child: Container(
          height: Utility(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, bottom: 20, right: 20),
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
                  Container(
                    height: 50,
                    width: Utility(context).width * 0.65,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Color(0xff1C1D1E),
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: FittedBox(
                              child: Text(
                        videoTitle ?? "",
                        style: TextStyle(color: Colors.white),
                      ))),
                    ),
                  )
                ],
              ),
              Container(
                  height: 255,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: VideoPlayerWidget(
                    videoUrl: videoUrl,
                  )),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: DescriptionWidget(
                  videoTitle: videoTitle,
                  videoDescription: discription,
                  // videoId: videosId,
                  // videoData: videoData,
                  // videoDescription: videoDescp ?? '',
                  // videoTitle: videoTitle,
                  // datas: datas,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
