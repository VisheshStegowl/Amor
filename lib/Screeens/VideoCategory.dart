import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/VideoCategoryDataModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/VideoCategoryList.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';

class VideoCategory extends StatefulWidget {
  const VideoCategory({Key key}) : super(key: key);
  @override
  State<VideoCategory> createState() => _VideoCategoryState();
}

class _VideoCategoryState extends State<VideoCategory> {
  Future<VideoCategoryDataModel> videoCategoryList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoCategoryList = APIClient().videoCategory();

    // assetsAudioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isVideo: true),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: SafeArea(
        child: Container(
          height: Utility(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<VideoCategoryDataModel>(
              future: videoCategoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            itemCount: snapshot.data.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.6,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 12),
                            itemBuilder: (context, index) {
                              if (snapshot.data.data.isNotEmpty) {
                                return InkWell(
                                  onTap: () async {
                                    Navigator.push(context, PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation,
                                            Animation<double>
                                                secondaryAnimation) {
                                      return VideoCategoryList(
                                        vidoeId: snapshot
                                            .data.data[index].videocategoryId
                                            .toString(),
                                        title: snapshot.data.data[index].name,
                                      );
                                    }));
                                  },
                                  child: Stack(
                                    children: [
                                      CoreImage(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.zero,
                                        url: snapshot.data.data[index].image,
                                        boxFit: BoxFit.cover,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 10, right: 10),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                stops: const [0.6, 0.75, 0.8],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black
                                                      .withOpacity(0.55),
                                                  Colors.black.withOpacity(0.75)
                                                ])),
                                        child: Row(children: [
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              snapshot.data.data[index].name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          const Flexible(
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                              size: 29,
                                            ),
                                          )
                                        ]),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'No Data Found !!',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ]);
                              }
                            })
                      ],
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: appColor,
                    semanticsLabel: 'Loading',
                  ));
                }
              }),
        ),
      ),
    );
  }
}
