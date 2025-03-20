import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/MenuModel.dart';
import 'package:amor_93_7_fm/Screeens/SongCategoryList.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/Cells/SongCategoryCell.dart';
import 'package:amor_93_7_fm/Screeens/Login.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';

// ignore: must_be_immutable
class MenuList extends StatefulWidget {
  MenuList({Key key}) : super(key: key);
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  Future<MenuModel> MenuList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MenuList = APIClient().getArtist("1");
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
            height: Utility(context).height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder<MenuModel>(
                future: MenuList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.status);
                    if (snapshot.data.status == 200) {
                      // snapshot.data.data
                      if (snapshot.data.data.length == 0) {
                        return Center(
                            child: Text(
                          "No Data Found",
                          style: TextStyle(color: white),
                        ));
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 20),
                                  child: Image.asset(
                                    "assets/images/ic_logo.png",
                                    height: 100,
                                    width: 150,
                                  ),
                                );
                              } else {
                                return Container(
                                    height: 100,
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: SongCategoryCell(
                                      title: snapshot
                                          .data.data[index - 1].menuName,
                                      img: snapshot
                                          .data.data[index - 1].menuImage,
                                      onPress: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    SongCategoryList(
                                                      type: snapshot
                                                          .data
                                                          .data[index - 1]
                                                          .menuId
                                                          .toString(),
                                                      menuName: snapshot
                                                          .data
                                                          .data[index - 1]
                                                          .menuName,
                                                    )));
                                      },
                                    ));
                              }
                            });
                      }
                    } else if (snapshot.data.status == 401) {
                      Dialogs.showOSDialog(
                          context, appName, snapshot.data.message, ok, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
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
                  return Center(
                      child: CircularProgressIndicator(
                    color: appColor,
                    semanticsLabel: 'Loading',
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
