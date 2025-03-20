import 'package:amor_93_7_fm/Screeens/BookingScreen.dart';
import 'package:amor_93_7_fm/Screeens/HomeScreen.dart';
import 'package:amor_93_7_fm/Screeens/MenuList.dart';
import 'package:amor_93_7_fm/Screeens/MoreScreen.dart';
import 'package:amor_93_7_fm/Screeens/VideoCategory.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Screeens/LiveRadio.dart';
import 'package:amor_93_7_fm/Screeens/LiveVideoVC.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';

// ignore: camel_case_types
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key key,
      this.defaultAppBar,
      this.isIntro = false,
      this.isStream = false,
      this.isRadio = false,
      this.isbooking = false,
      this.isMusic = false,
      this.isVideo = false})
      : super(key: key);
  final AppBar defaultAppBar;
  final bool isIntro;
  final bool isStream;
  final bool isbooking;
  final bool isRadio;
  final bool isMusic;
  final bool isVideo;

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(87);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(widget.defaultAppBar.preferredSize.height);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: preferredSize.width,
                height: preferredSize.height - 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        child: Image.asset(
                          "assets/images/introtab.png",
                          width: 20,
                          height: 20,
                          color: widget.isIntro ? appColor : Colors.white,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => HomeScreen()),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LiveRadio()),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: Image.asset("assets/images/radiotab.png",
                            width: 15,
                            height: 20,
                            color: widget.isRadio ? appColor : Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        child: Image.asset("assets/images/streamtab.png",
                            width: 40,
                            height: 20,
                            color: widget.isStream ? appColor : Colors.white),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LiveVideoVC()),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        child: Image.asset("assets/images/LiveTV.png",
                            width: 10,
                            height: 18,
                            color: widget.isVideo ? appColor : Colors.white),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const VideoCategory()),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        child: Image.asset("assets/images/musictab.png",
                            width: 20,
                            height: 20,
                            color: widget.isMusic ? appColor : Colors.white),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MenuList()),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: Utility(context).width / 6,
                      child: InkWell(
                        child: Image.asset("assets/images/bookingstab.png",
                            width: 20,
                            height: 20,
                            color: widget.isbooking ? appColor : Colors.white),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MoreScreen()),
                          ).then((value) {
                            if (this.mounted) {
                              setState(() {});
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 0,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
