import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/Model/SongCategoryModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/Cells/SongCategoryCell.dart';
import 'package:amor_93_7_fm/Screeens/Login.dart';
import 'package:amor_93_7_fm/Screeens/SongList.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';

import '../Utility/Constants.dart';

// ignore: must_be_immutable
class SongCategoryList extends StatefulWidget {
  SongCategoryList({Key key, this.type, this.menuName}) : super(key: key);
  final String type;
  final String menuName;

  @override
  _SongCategoryListState createState() => _SongCategoryListState();
}

class _SongCategoryListState extends State<SongCategoryList> {
  Future<SongCategoryModel> SongCategoryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongCategoryList = APIClient().getSongCategory(widget.type, "1");
    if (videoController != null) {
      videoController.pause();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(defaultAppBar: AppBar(), isMusic: true),
        bottomNavigationBar: MyBottomBar(appBar: AppBar()),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
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
                          widget.menuName ?? "",
                          style: TextStyle(color: Colors.white),
                        ))),
                      ),
                    )
                  ],
                ),
                FutureBuilder<SongCategoryModel>(
                    future: SongCategoryList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.status);
                        if (snapshot.data.status == 200) {
                          // snapshot.data.data
                          if (snapshot.data.data.length == 0) {
                            return Expanded(
                              child: Center(
                                  child: Text(
                                "No Data Found",
                                style: TextStyle(color: white),
                              )),
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: Utility(context).width * 0.283,
                                      child: _SongArtistTile(
                                          snapshot.data.data[index].artist ??
                                              "artist",
                                          snapshot.data.data[index].name,
                                          snapshot.data.data[index].image, () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    SongList(
                                                        songCategoryId: snapshot
                                                            .data
                                                            .data[index]
                                                            .songcategoryId,
                                                        CatImg: snapshot.data
                                                            .data[index].image,
                                                        CatTitle: snapshot
                                                            .data
                                                            .data[index]
                                                            .name))).then(
                                            (value) {
                                          setState(() {});
                                        });
                                      }),
                                    );
                                  }),
                            );
                          }
                        } else if (snapshot.data.status == 401) {
                          Dialogs.showOSDialog(
                              context, appName, snapshot.data.message, ok, () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          });
                          return Text(
                            snapshot.data.message,
                            style: TextStyle(color: Colors.white),
                          );
                        } else {
                          return Text(
                            snapshot.data.message,
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      } else if (snapshot.hasError) {
                        print("${snapshot.error}");
                        return Text(
                          "${snapshot.error}",
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: appColor,
                        semanticsLabel: 'Loading',
                      )));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _SongArtistTile(
      String artist, String album, String img, GestureTapCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xff1C1D1E), borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    child: img == ""
                        ? Image.asset(
                            "assets/images/ic_placeholder.png",
                            fit: BoxFit.contain,
                          )
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/images/ic_placeholder.png',
                            image: img,
                            fit: BoxFit.fill,
                            height: 60,
                            width: 60,
                          ),
                    height: 60,
                    width: 60,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //       "ARTIST: ",
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: Utility(context).width * 0.27,
                  //       child: Text(
                  //         "$artist",
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text(
                        "Album Name: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: Utility(context).width * 0.2,
                        child: Text(
                          "$album",
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              Image.asset(
                "assets/images/right-arrow.png",
                fit: BoxFit.contain,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
