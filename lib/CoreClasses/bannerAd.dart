// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import '../Utility/Constants.dart';
//
// class bannerAd extends StatefulWidget{
//   @override
//   State<bannerAd> createState() => _bannerAdState();
// }
//
// class _bannerAdState extends State<bannerAd> {
//   BannerAd _bannerAd;
//
//   final String _adUnitId = Platform.isAndroid
//       ? (cmsData.socialmediaData.first.androidKey == "" ? "ca-app-pub-3940256099942544/2934735716" : cmsData.socialmediaData.first.androidKey)
//       : (cmsData.socialmediaData.first.iosKey == "" ? "ca-app-pub-3940256099942544/2934735716" : cmsData.socialmediaData.first.iosKey);
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAd();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: _bannerAd.size.width.toDouble(),
//       height: _bannerAd.size.height.toDouble(),
//       child: AdWidget(ad: _bannerAd),
//     );
//   }
//
//   /// Loads and shows a banner ad.
//   ///
//   /// Dimensions of the ad are determined by the AdSize class.
//   void _loadAd() async {
//     BannerAd(
//       adUnitId: _adUnitId,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           setState(() {
//             _bannerAd = ad as BannerAd;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           ad.dispose();
//         },
//         // Called when an ad opens an overlay that covers the screen.
//         onAdOpened: (Ad ad) {},
//         // Called when an ad removes an overlay that covers the screen.
//         onAdClosed: (Ad ad) {},
//         // Called when an impression occurs on the ad.
//         onAdImpression: (Ad ad) {},
//       ),
//     ).load();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
// }
