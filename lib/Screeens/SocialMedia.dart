import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CoreClasses/MyBottomBar.dart';
import '../CoreClasses/appBar.dart';
import '../Utility/Colors.dart';
import '../Utility/Dialogs.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key key}) : super(key: key);

  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  String fb;
  String insta;
  String other;
  String twitter;

  @override
  void initState() {
    socialApi();
    super.initState();
  }

  void socialApi() async {
    fb = cmsData.socialmediaData.first.facebookLink;
    twitter = cmsData.socialmediaData.first.twitterLink;
    insta = cmsData.socialmediaData.first.instagramLink;
    other = cmsData.socialmediaData.first.youtubeLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isbooking: true),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Utility(context).width,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          top: 20,
                          bottom: 10,
                          right: Utility(context).width - 50),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      splashColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.black.withOpacity(0.3),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 500), () {
                          String url;
                          if (insta != null) {
                            url = insta;
                          } else {
                            url = "https://google.com";
                          }
                          launchURL(url);
                        });
                      },
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: white, width: 1.0),
                          // color: white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                        'assets/images/instagram.png',
                                        color: white),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Instagram",
                                  style: TextStyle(color: white, fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      splashColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.black.withOpacity(0.3),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 500), () {
                          String url;
                          if (twitter != null) {
                            url = twitter;
                          } else {
                            url = "https://google.com";
                          }
                          launchURL(url);
                        });
                      },
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: white, width: 1.0),
                          // color: white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                        'assets/images/twitter.png',
                                        color: white),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Twitter",
                                  style: TextStyle(color: white, fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      splashColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.black.withOpacity(0.3),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 100), () {
                          setState(() {
                            String url;
                            if (fb != null) {
                              url = fb;
                            } else {
                              url = "https://google.com";
                            }
                            launchURL(url);
                          });
                        });
                      },
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: white, width: 1.0),
                          // color: white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Facebook",
                                  style: TextStyle(color: white, fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      splashColor: Colors.black.withOpacity(0.3),
                      highlightColor: Colors.black.withOpacity(0.3),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 500), () {
                          String url;
                          if (other != null) {
                            url = other;
                          } else {
                            url = "https://google.com";
                          }
                          launchURL(url);
                        });
                      },
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: white, width: 1.0),
                          // color: white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      'assets/images/ic_social.png',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Other",
                                  style: TextStyle(color: white, fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                // child:
              ),
            )
          ],
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      NormalAlert.showAlertDialog(context, "Error", "Could not launch $url");
      // throw 'Could not launch $url';
    }
  }
}
