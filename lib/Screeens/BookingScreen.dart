import 'package:amor_93_7_fm/CoreClasses/MyBottomBar.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Model/bookingModel.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Networking/APIRouter.dart';
import '../Utility/Constants.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  WebViewController _controller;
  bool isLoader = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (videoController != null) {
      videoController.pause();
    }
    apicall();
  }

  apicall() async {
    setState(() {
      isLoader = true;
    });
    BookingModel model = await APIClient().getBooking();
    _controller = WebViewController()
      ..loadRequest(
        Uri.parse(model.data),
      );

    setState(() {
      isLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(defaultAppBar: AppBar(), isbooking: true),
      bottomNavigationBar: MyBottomBar(appBar: AppBar()),
      body: isLoader
          ? const Center(
              child: CircularProgressIndicator(
              color: appColor,
            ))
          : WebViewWidget(controller: _controller),
    );
  }
}
