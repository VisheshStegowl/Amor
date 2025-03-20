import 'package:cached_network_image/cached_network_image.dart';
import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/DailyShowModel.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Screeens/DailyShowDetails.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';

class DailyShowScreen extends StatefulWidget {
  const DailyShowScreen({Key key}) : super(key: key);

  @override
  State<DailyShowScreen> createState() => _DailyShowScreenState();
}

class _DailyShowScreenState extends State<DailyShowScreen> {
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
          child: FutureBuilder<DailyShowModel>(
              future: APIClient().dailyShowsApi(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Image.asset(
                                          "assets/images/back.png",
                                          color: Colors.white,
                                          width: 30,
                                          height: 20,
                                        ),
                                      ),
                                    )),
                                const Center(
                                  child: Text("Daily Shows",
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
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 15, bottom: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.65,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DailyShowDetails(
                                                  data: snapshot
                                                          .data.data[index] ??
                                                      DailyShowData(),
                                                )));
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              offset: Offset(2, 3)),
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CachedNetworkImage(
                                            placeholder: (context, data) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: appColor,
                                              ));
                                            },
                                            width: double.maxFinite,
                                            fit: BoxFit.fill,
                                            imageUrl: snapshot
                                                .data.data[index].eventImage,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          snapshot.data.data[index].eventName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: appColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          snapshot.data.data[index].eventDays,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Flexible(
                                            child: Row(
                                          children: [
                                            Text(
                                              snapshot.data.data[index]
                                                  .eventStartTime,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " - ",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Flexible(
                                                child: Text(
                                              snapshot.data.data[index]
                                                  .eventEndTime,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                            )),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data.data.length,
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: appColor,
                        ),
                      );
              }),
        ));
  }
}
