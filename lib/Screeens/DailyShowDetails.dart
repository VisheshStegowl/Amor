import 'package:cached_network_image/cached_network_image.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/DailyShowModel.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DailyShowDetails extends StatelessWidget {
  final DailyShowData data;
  const DailyShowDetails({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(defaultAppBar: AppBar(), isbooking: true),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text("Daily Show Detils",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      )
                    ],
                  ),
                ),
                Center(
                  child: CachedNetworkImage(
                    width: double.maxFinite,
                    fit: BoxFit.fill,
                    imageUrl: data.eventImage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.eventName,
                        style: const TextStyle(
                            fontSize: 25,
                            color: appColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.eventDays,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            data.eventStartTime,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " - ",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                              child: Text(
                            data.eventEndTime,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      HtmlWidget(
                        data.eventDescription.toString(),
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
