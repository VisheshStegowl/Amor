import 'package:amor_93_7_fm/Model/NotificationModel.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';

import '../CoreClasses/MyBottomBar.dart';
import '../CoreClasses/appBar.dart';
import '../Networking/APIRouter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<NotificationModel> notiObj;

  @override
  void initState() {
    notiObj = APIClient().getNotification();
    super.initState();
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
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "assets/images/back.png",
                            color: Colors.white,
                            width: 30,
                            height: 20,
                          ),
                        ),
                      )),
                  Center(
                    child: Text("Notifications",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: notiObj,
                  builder: (BuildContext context,
                      AsyncSnapshot<NotificationModel> snap) {
                    if (snap.hasData) {
                      var notiData = snap.data.data;
                      if (notiData.isEmpty) {
                        return Expanded(
                            child: Container(
                                child: const Center(
                          child: Text(
                            "No Data Found",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        )));
                      }
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: notiData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      // color: Colors,
                                      child: Text(
                                        notiData[index].title,
                                        textAlign: TextAlign.left,
                                        maxLines: 100,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        notiData[index].message,
                                        maxLines: 500,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: white, fontSize: 13),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 1,
                                          color: appGray.withOpacity(0.3),
                                        )),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else if (snap.hasError) {
                      print("${snap.error}");
                      return Text(
                        "${snap.error}",
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                    // By default, show a loading spinner.
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: appColor,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
