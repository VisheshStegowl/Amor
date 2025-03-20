import 'dart:async';
import 'dart:io';
import 'package:amor_93_7_fm/Screeens/LiveRadio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyButton.dart';
import 'package:amor_93_7_fm/Model/AppUserModel.dart';
import 'package:amor_93_7_fm/Model/CMSModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/HomeScreen.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';
import 'package:amor_93_7_fm/Utility/UserDefaults.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController(initialPage: 0);
  Future<CMSModel> introObj;
  List<IntroductionsliderData> introArr;
  String title = "Next";
  int currentIndex = 0;
  UserDefaults userDefault = UserDefaults.instance;
  Timer timer;

  @override
  void initState() {
    UserDefaults.instance.setBool(key_tutorial, true);
    introObj = APIClient().getcms();
    super.initState();
    print("intro screen entered");
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBGColor,
        body: Container(
          child: FutureBuilder(
            future: introObj,
            builder: (context, AsyncSnapshot<CMSModel> snap) {
              if (snap.hasData) {
                introArr = snap.data.introductionsliderData;
                if (introArr != null && timer == null) {
                  _addTimer();
                }
                return showTableView(context, introArr);
              }
              return progressView(context);
            },
          ),
        ));
  }

  Widget showTableView(
      BuildContext context, List<IntroductionsliderData> data) {
    if (data.length < 2) {
      title = "Enter App";
    }
    return SafeArea(
      bottom: false,
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: Utility(context).height,
              width: Utility(context).width,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return tutorialCell(context, data[index]);
                },
              ),
            ),
            SizedBox(
              height: Utility(context).height,
              width: Utility(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    // width: Utility(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: _skipIntroClicked,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "skip intro".toUpperCase(),
                              style: TextStyle(color: white, fontSize: 12),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: pictonBlue,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: introArr.length,
                    axisDirection: Axis.horizontal,
                    effect: WormEffect(
                        activeDotColor: pictonBlue,
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: appGray),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: _submitClicked,
                    child: CoreButton(
                      title: title,
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.5,
                      color: pictonBlue,
                      radius: 8,
                      titleColor: appBlack,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (currentIndex < introArr.length) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    });
  }

  Widget tutorialCell(BuildContext context, IntroductionsliderData data) {
    return Image.network(
      data.image,
      width: Utility(context).width,
      fit: BoxFit.fill,
      height: Utility(context).width,
    );
  }

  _onPageChanged(int index) {
    currentIndex = index;
    title = (introArr.length - 1) == index ? "Enter App" : "Next";
    setState(() {});
  }

  _skipIntroClicked() {
    checkScreen();
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginVC()));
  }

  menuStatusApi() async {
    // print("before timer${Constants.userModel.userId}");
    var pref = await SharedPreferences.getInstance();
    if (pref.getString(key_userdata) != null) {
      AppUserModel userModel =
          AppUserModel.fromJson(await userDefault.read(key_userdata));
      Constants.userModel = userModel;
      Timer(
        Duration(seconds: 1),
        // kunal
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LiveRadio()
                // ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(isFirst: true,)
                )),
      );
    } else {
      Timer(Duration(seconds: 1), () {
        loginApi();
      });
    }
  }

  void loginApi() async {
    String device =
        Theme.of(context).platform == TargetPlatform.iOS ? "ios" : "android";
    if (Constants.fmcToken == "") {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.getAPNSToken();
      }
      Constants.fmcToken = await FirebaseMessaging.instance.getToken();
      print("FCM token is here ${Constants.fmcToken}");
    }
    var param = {"device_type": device, "fcm_id": Constants.fmcToken};
    AppUserModel user = await APIClient().appUser(param);
    if (user.status >= 200 && user.status <= 210) {
      UserDefaults.instance.save(key_userdata, user);
      AppUserModel userModel =
          AppUserModel.fromJson(await UserDefaults.instance.read(key_userdata));
      Constants.userModel = userModel;
      UserDefaults.instance
          .setString(key_userID, Constants.userModel.userId.toString());
      // Navigator.pushReplacement(context, MaterialPageRoute( builder: (BuildContext context) => HomeScreen(isFirst: true,)));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LiveRadio()));
    } else {
      UserDefaults.instance.remove(key_userdata);
      UserDefaults.instance.remove(key_email);
      UserDefaults.instance.remove(key_password);
      UserDefaults.instance.remove(key_accesstoken);
      Dialogs.showOSDialog(context, appName, user.message, ok, () => {});
    }
  }

  void checkScreen() async {
    menuStatusApi();
  }

  _submitClicked() {
    if ((introArr.length - 1) == currentIndex) {
      checkScreen();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginVC()));
    } else {
      setState(() {
        _pageController.animateToPage(currentIndex + 1,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
  }
}
