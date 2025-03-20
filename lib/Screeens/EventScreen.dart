import 'package:amor_93_7_fm/CoreClasses/appBar.dart';
import 'package:amor_93_7_fm/Model/EventModelClass.dart';
import 'package:amor_93_7_fm/Model/TermsAndConditionModelClass.dart';
import 'package:amor_93_7_fm/Networking/APIRouter.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // WebViewController _controller;
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
        defaultAppBar: AppBar(),
        isbooking: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        // <DailyShowModel>
        child: FutureBuilder<EventModelClass>(
            future: APIClient().eventApi(),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Image.asset(
                                        "assets/images/back.png",
                                        color: Colors.white,
                                        width: 30,
                                        height: 20,
                                      ),
                                    ),
                                  )),
                              const Center(
                                child: Text("Events",
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
                            child: ListView.builder(
                                itemCount: snapshot.data?.data?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              height: (Utility(context).width *
                                                      0.9) +
                                                  300,
                                              child: PageView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller: _pageController,
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                onPageChanged: _onPageChanged,
                                                itemCount: snapshot
                                                    .data
                                                    .data[index]
                                                    .sliderImages
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index1) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      snapshot.data?.data[index]
                                                          .sliderImages[index1],
                                                      fit: BoxFit.contain,
                                                      height: (Utility(context)
                                                              .height *
                                                          0.23),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SmoothPageIndicator(
                                              controller: _pageController,
                                              count: snapshot.data?.data[index]
                                                  .sliderImages.length,
                                              axisDirection: Axis.horizontal,
                                              effect: const WormEffect(
                                                  activeDotColor: pictonBlue,
                                                  dotHeight: 15,
                                                  dotWidth: 15,
                                                  dotColor: indicatorColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${snapshot.data.data[index].eventNoPrefix}${snapshot.data.data[index].eventNo}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          snapshot.data.data[index].eventName,
                                          style: const TextStyle(
                                              fontSize: 26,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        HtmlWidget(
                                          snapshot.data.data[index].eventDesc
                                              .toString(),
                                        ),
                                        // Html(
                                        //   shrinkWrap: true,
                                        //   style: {"p": Style(color: white)},
                                        //   data: snapshot
                                        //       .data.data[index].eventDesc
                                        //       .toString(),
                                        // ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Venue: @ ${snapshot.data.data[index].venueName}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.language,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Where \n${snapshot.data.data[index].eventLocation}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range_sharp,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "When \n${snapshot.data.data[index].eventDate}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Venue Detail",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data.data[index].venueName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.pink,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        snapshot.data.data[index].venueLocation
                                                .contains("<p>")
                                            ? Html(
                                                data: snapshot.data.data[index]
                                                    .venueLocation,
                                                style: {
                                                  "p": Style(
                                                      padding:
                                                          HtmlPaddings.zero,
                                                      color: Colors.white)
                                                },
                                              )
                                            : Text(
                                                snapshot.data.data[index]
                                                    .venueLocation,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .venueGooglemap));
                                              },
                                              child: const Text(
                                                "VIEW MAP LOCATION",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16,
                                                    color: Colors.pink,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 45,
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Flexible(
                                              child: Text(
                                                "WATCH PROMO VIDEO",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .videoUrl));
                                              },
                                              child: const Icon(
                                                  Icons.play_circle,
                                                  color: Colors.orange,
                                                  size: 45),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Color(0xFFd70f91),
                                                Color(0xFFd70f91)
                                                    .withOpacity(0.5)
                                              ]),
                                              // color: Color(0xFFd70f91),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50,
                                          width: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${snapshot.data.data[index].eventdata1}:",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "${snapshot.data.data[index].eventcontain1}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Color(0xFFd70f91),
                                                Color(0xFFd70f91)
                                                    .withOpacity(0.5)
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50,
                                          width: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${snapshot.data.data[index].eventdata2}:",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "${snapshot.data.data[index].eventcontain2}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Color(0xFFd70f91),
                                                Color(0xFFd70f91)
                                                    .withOpacity(0.5)
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50,
                                          width: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${snapshot.data.data[index].eventdata3}:",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                snapshot.data.data[index]
                                                    .eventcontain3,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snapshot
                                                              .data
                                                              ?.data[index]
                                                              ?.tablesList
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, listIndex) {
                                                        return snapshot
                                                                    .data
                                                                    ?.data[
                                                                        index]
                                                                    ?.tablesList[
                                                                        listIndex]
                                                                    .available ==
                                                                1
                                                            ? Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      launchUrl(Uri.parse(snapshot
                                                                          .data
                                                                          ?.data[
                                                                              index]
                                                                          ?.tablesList[
                                                                              listIndex]
                                                                          .buttonLink));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.02,
                                                                      ),
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              1.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                                colors: [
                                                                              Color(0xFFd70f91),
                                                                              Color(0xFFd70f91).withOpacity(0.5)
                                                                            ]),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      height:
                                                                          50,
                                                                      width: double
                                                                          .maxFinite,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data?.data[index]?.tablesList[listIndex].tableName ?? 'N/A'}",
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // const Flexible(
                                                                          //    child:
                                                                          //        Text(
                                                                          //      "Cost Of This Table is",
                                                                          //      style:
                                                                          //           TextStyle(
                                                                          //        fontSize:
                                                                          //            16,
                                                                          //        color:
                                                                          //            Colors.white,
                                                                          //        fontWeight:
                                                                          //            FontWeight.w600,
                                                                          //      ),
                                                                          //    ),
                                                                          //  ),
                                                                          //  Flexible(
                                                                          //    child:
                                                                          //        Text(
                                                                          //      "${snapshot.data?.data[index]?.tablesList[listIndex].tablePrice ?? 'N/A'} USD",
                                                                          //      style:
                                                                          //          const TextStyle(
                                                                          //        fontSize:
                                                                          //            16,
                                                                          //        color:
                                                                          //            Colors.white,
                                                                          //        fontWeight:
                                                                          //            FontWeight.w600,
                                                                          //      ),
                                                                          //    ),
                                                                          //  ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox.shrink();
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFFd70f91),
                                                      Color(0xFFd70f91)
                                                          .withOpacity(0.5)
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 50,
                                            width: double.maxFinite,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${snapshot.data.data[index].buttonName}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: double.maxFinite,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  APIClient()
                                                      .terms()
                                                      .then((value) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight:
                                                                      450),
                                                          child: AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            title: SizedBox(
                                                                width: double
                                                                    .maxFinite,
                                                                child: Text(value
                                                                    .data[0]
                                                                    .title)),
                                                            content: SizedBox(
                                                              width: double
                                                                  .maxFinite,
                                                              child: value
                                                                      .data[0]
                                                                      .description
                                                                      .contains(
                                                                          "<p>")
                                                                  ? Html(
                                                                      data: value
                                                                          .data[
                                                                              0]
                                                                          .description,
                                                                      style: {
                                                                        // "span style": Style(
                                                                        //   fontFamily:
                                                                        // )
                                                                        // <=\"font-family: 'Open Sans'
                                                                        "p": Style(
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            textAlign: TextAlign
                                                                                .justify,
                                                                            fontFamily:
                                                                                "Open Sans",
                                                                            padding:
                                                                                HtmlPaddings.zero,
                                                                            color: Colors.black)
                                                                      },
                                                                    )
                                                                  : Text(
                                                                      value
                                                                          .data[
                                                                              0]
                                                                          .description,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      "Ok"))
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  });
                                                },
                                                child: const Text(
                                                  "Purchase Terms & Condition",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .facebookLink));
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                    "assets/images/facebook.png",
                                                    color: Colors.black,
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .twitterLink));
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                    "assets/images/twitter.png",
                                                    color: Colors.black,
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .linkdinLink));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                  "assets/images/LinkedIn.png",
                                                  // color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .youtubeLink));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                  "assets/images/Youtube.png",
                                                  // color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(Uri.parse(snapshot
                                                    .data
                                                    .data[index]
                                                    .instagramLink));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                  "assets/images/instagram.png",
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          height: 20,
                                          thickness: 2,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: appColor,
                      ),
                    );
            }),
      ),
    );
  }

  _onPageChanged(int index) {
    currentIndex = index;
    setState(() {});
  }
}
