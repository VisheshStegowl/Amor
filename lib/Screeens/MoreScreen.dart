import 'package:amor_93_7_fm/Screeens/DailyShowScreen.dart';
import 'package:amor_93_7_fm/Screeens/EventScreen.dart';
import 'package:amor_93_7_fm/Screeens/Playlist.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CoreClasses/MyBottomBar.dart';
import '../CoreClasses/appBar.dart';
import 'BookingScreen.dart';
import 'FavList.dart';
import 'NotificationScreen.dart';
import 'SocialMedia.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
// List data = ["Notifications","Booking","Social Media","Playlist","Favorites"];
  List data = [
    "Daily Shows",
    "Events",
    "Social Media",
    "My Music Playlist",
    "My Music Favorites",
    "My Notifications",
    "Contact Us",
    'Privacy Policies'
  ];
// onTap: (){
// if (index == 0){
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => NotificationScreen()),).then((value){
// setState(() {});
// });
// }else if (index == 2){
// // SocialMedia
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => SocialMedia()),).then((value){
// setState(() {});
// });
// }else if (index == 1){
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => BookingScreen()),).then((value){
// setState(() {});
// });
// }else if (index == 3){
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => SocialMedia()),).then((value){});
// }else if(index==4){
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => PlaylistScreen()),).then((value){});
// }else if(index==5){
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => FavList()),).then((value){});
// }else{
// Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => NotificationScreen()),).then((value){});
//
// }
// },
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
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  // onTap: (){
                  //   if (index == 0){
                  //     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => NotificationScreen()),).then((value){
                  //       setState(() {});
                  //     });
                  //   }else if (index == 2){
                  //     // SocialMedia
                  //     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => SocialMedia()),).then((value){
                  //       setState(() {});
                  //     });
                  //   }else if (index == 1){
                  //     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => BookingScreen()),).then((value){
                  //       setState(() {});
                  //     });
                  //   }else if (index == 3){
                  //     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => PlaylistScreen()),).then((value){});
                  //   }else{
                  //     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => FavList()),).then((value){});
                  //   }
                  // },
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => DailyShowScreen()),
                      ).then((value) {
                        setState(() {});
                      });
                    } else if (index == 1) {
// SocialMedia
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => EventScreen()),
                      ).then((value) {
                        setState(() {});
                      });
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SocialMedia()),
                      ).then((value) {});
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => PlaylistScreen()),
                      ).then((value) {});
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => FavList()),
                      ).then((value) {});
                    } else if (index == 5) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => NotificationScreen()),
                      ).then((value) {
                        setState(() {});
                      });
                    } else if (index == 6) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => BookingScreen()),
                      ).then((value) {
                        setState(() {});
                      });
                    } else {
                      launchUrl(Uri.parse("https://amor937.com/terms"));
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: Utility(context).width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 1,
                            color: appGray.withOpacity(0.3),
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
