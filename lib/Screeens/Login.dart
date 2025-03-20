import 'package:amor_93_7_fm/Screeens/HomeScreen.dart';
import 'package:amor_93_7_fm/Screeens/LiveRadio.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/CoreClasses/MyButton.dart';
import 'package:amor_93_7_fm/CoreClasses/MyTextfield.dart';
import 'package:amor_93_7_fm/Model/UserModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/SongCategoryList.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/CommanString.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:amor_93_7_fm/Utility/Dialogs.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';
import 'package:amor_93_7_fm/Utility/UserDefaults.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  bool isRemember = false;
  bool isShowPassword = false;
  String email = "";
  String password = "";
  String accessToken = "";
  bool isShowLoader = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _accessController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  void initState() {
    UserDefaults.instance.getStrings(key_email).then((value) => setState(() {
          _emailController.text = value;
          email = value;
        }));
    UserDefaults.instance.getStrings(key_password).then((value) => setState(() {
          _passController.text = value;
          password = value;
        }));
    UserDefaults.instance
        .getStrings(key_accesstoken)
        .then((value) => setState(() {
              _accessController.text = value;
              accessToken = value;
            }));

    UserDefaults.instance.getBool(key_remember).then((value) => setState(() {
          isRemember = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appBlack,
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/ic_background.png',
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    height: Utility(context).height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ic_logo.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 150,
                                  fit: BoxFit.fill,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                  controller: _emailController,
                                  hintText: "Enter email",
                                  topPlaceholer: "Email",
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (value) => {email = value},
                                  secureText: false,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                    controller: _passController,
                                    hintText: "Enter password",
                                    topPlaceholer: "Password",
                                    secureText: !isShowPassword,
                                    onChanged: (value) => {password = value},
                                    height: 70,
                                    suffixIcon: InkWell(
                                      onTap: _showPassClicked,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            (isShowPassword)
                                                ? 'assets/images/hide.png'
                                                : 'assets/images/red-eye.png',
                                            height: 20,
                                            width: 30,
                                            color: appGray.shade700,
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                  controller: _accessController,
                                  hintText: "Enter access token",
                                  topPlaceholer: "Access Token",
                                  textInputType: TextInputType.number,
                                  onChanged: (value) => {accessToken = value},
                                  secureText: false,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: InkWell(
                              onTap: () => {
                                setState(() {
                                  isRemember = isRemember == null
                                      ? true
                                      : isRemember
                                          ? false
                                          : true;
                                })
                              },
                              child: Container(
                                height: 35,
                                width: 190,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: appColor),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (isRemember == true)
                                            Container(
                                              height: 18,
                                              width: 18,
                                              color: appBlack,
                                              child: Image.asset(
                                                'assets/images/ic_check.png',
                                              ),
                                            )
                                          else
                                            Container(
                                              height: 18,
                                              width: 18,
                                              color: appBlack,
                                            )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "rememeber me".toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: InkWell(
                              onTap: _loginClicked,
                              child: CoreButton(
                                title: "LOGIN",
                                height: 50,
                                width: MediaQuery.of(context).size.width - 60,
                                color: appColor,
                                titleColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            isShowLoader
                ? Align(
                    alignment: Alignment.center, child: progressView(context))
                : Container(),
          ],
        ),
      ),
    );
  }

  bool isValid() {
    String msg = "";
    _emailController.text = email;
    _passController.text = password;
    if (_emailController.text == null || _emailController.text == "") {
      msg = pleaseEnterEmailorUsername;
    } else if (_passController.text == null || _passController.text == "") {
      msg = pleaseEnterPassword;
    } else if (_accessController.text == null || _accessController.text == "") {
      msg = "Please enter your access token";
    }

    if (msg.isEmpty) {
      return true;
    } else {
      Dialogs.showOSDialog(context, appName, msg, ok, () => {});
      return false;
    }
  }

  void _loginClicked() {
    if (isValid() == true) {
      loginApi(email.isValidEmail() == true);
    }
  }

  void _showPassClicked() {
    isShowPassword = !isShowPassword;
    setState(() {});
  }

  void loginApi(bool isEmail) async {
    String device =
        Theme.of(context).platform == TargetPlatform.iOS ? "iOS" : "android";
    var param = {
      "login_id": email,
      "password": password,
      "access_token": accessToken,
      "device_type": device,
      "fcm_id": Constants.fmcToken
    };
    setState(() {
      isShowLoader = true;
    });
    UserModel user = await APIClient().login(param);
    setState(() {
      isShowLoader = false;
    });
    if (user.status >= 200 && user.status <= 210) {
      UserDefaults.instance.save(key_userdata, user);
      UserModel userModel =
          UserModel.fromJson(await UserDefaults.instance.read(key_userdata));
      // Constants.userModel = userModel;
      UserDefaults.instance
          .setString(key_email, isRemember == true ? email : "");
      UserDefaults.instance
          .setString(key_password, isRemember == true ? password : "");
      UserDefaults.instance
          .setString(key_accesstoken, isRemember == true ? accessToken : "");
      UserDefaults.instance.setBool(key_remember, isRemember == true);
      // kunal
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
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
}
