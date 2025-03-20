import 'package:amor_93_7_fm/Screeens/LiveRadio.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Model/AppUserModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/IntroScreen.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/UserDefaults.dart';

import 'HomeScreen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  UserDefaults userDefault = UserDefaults.instance;

  @override
  void initState() {
    checkScreen();
    super.initState();
  }

  menuStatusApi() async {
    // print("before timer${Constants.userModel.userId}");
    var pref = await SharedPreferences.getInstance();
    // loginApi();
    if (pref.getString(key_userdata) != null) {
      AppUserModel userModel =
          AppUserModel.fromJson(await userDefault.read(key_userdata));
      Constants.userModel = userModel;
      // Timer(Duration(seconds: 0),
      //       ()=>
      // by kunal
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(isFirst: true,)
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LiveRadio()) //),
          );
    } else {
      // Timer(Duration(seconds: 0),
      //       (){
      // loginApi();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
      // }
      // );
    }
  }

  void loginApi() async {
    String device =
        Theme.of(context).platform == TargetPlatform.iOS ? "ios" : "android";
    var param = {"device_type": device, "fcm_id": Constants.fmcToken};
    AppUserModel user = await APIClient().appUser(param);
    if (user.status >= 200 && user.status <= 210) {
      UserDefaults.instance.save(key_userdata, user);
      AppUserModel userModel =
          AppUserModel.fromJson(await UserDefaults.instance.read(key_userdata));
      Constants.userModel = userModel;
      UserDefaults.instance
          .setString(key_userID, Constants.userModel.userId.toString());
      // kunal
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen(isFirst: true,)));
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

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/whole_app_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
            child: Image.asset(
          'assets/images/LaunchScreen.png',
        )),
      ),
    );
  }
}
