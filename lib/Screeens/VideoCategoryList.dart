import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/CoreClasses/MyImage.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/VideoCategoryListDataModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/VideoPlayScreen.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';

class VideoCategoryList extends StatefulWidget {
  final String vidoeId;
  final String title;
  const VideoCategoryList({Key key, this.vidoeId, this.title})
      : super(key: key);

  @override
  State<VideoCategoryList> createState() => _VideoCategoryListState();
}

class _VideoCategoryListState extends State<VideoCategoryList> {
  Future<VideoCategoryListDataModel> categoryListData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is video id ${widget.vidoeId}");
    categoryListData = APIClient().videoCategoryList(widget.vidoeId);
    print("this is data ${categoryListData}");
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
          child: FutureBuilder<VideoCategoryListDataModel>(
              future: categoryListData,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
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
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xff1C1D1E),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: FittedBox(
                                        child: Text(
                                  widget.title ?? "",
                                  style: const TextStyle(color: Colors.white),
                                ))),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          itemCount: snapshot.data.data.length ?? 1,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data.data.isNotEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, PageRouteBuilder(
                                      pageBuilder: (_, __, ___) {
                                    return VideoPlayScreen(
                                      videoTitle:
                                          snapshot.data.data[index].name,
                                      videoUrl: snapshot.data.data[index].video,
                                      discription:
                                          snapshot.data.data[index].description,
                                    );
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    children: [
                                      // CachedNetworkImageWidget(
                                      //   width: double.maxFinite,
                                      //   height: double.maxFinite,
                                      //   image: controller.videoCategoryDataListModel
                                      //       .value?.data?[index].videosImage ??
                                      //       '',
                                      //   fit: BoxFit.cover,
                                      // ),
                                      CoreImage(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        borderRadius: BorderRadius.zero,
                                        url: snapshot.data.data[index].image,
                                        boxFit: BoxFit.cover,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                stops: [0.7, 0.8, 0.85],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black
                                                      .withOpacity(0.65),
                                                  Colors.black.withOpacity(0.75)
                                                ])),
                                        child: Text(
                                          snapshot.data.data[index].name,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: appRedColor, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  'No Data Found !!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
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
