// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:amor_93_7_fm/Model/LiveVideoModel.dart';
// import 'package:amor_93_7_fm/Utility/Constants.dart';
//
// typedef VoidCallback = void Function();
//
// class VideoPlayerManager {
//   static final VideoPlayerManager shared = VideoPlayerManager();
//   static  BetterPlayerController playerController;
//   static  GlobalKey playerKey = GlobalKey();
//   static BetterPlayerDataSource dataSource;
//   static BetterPlayerConfiguration betterPlayerConfiguration;
//   // pause() {
//   //   playerController?.pause();
//   // }
//   playLiveVideo(LiveVideo data,bool isNext){
//     // isNextPre = 2;
//     // if (isNext == true){
//     //
//     //   // playerController.videoPlayerController = null;
//     //   // dataSource = null;
//     //   playerController.videoPlayerController.pause();
//     //   playerController.dispose();
//     //   playerController.videoPlayerController.dispose();
//     //   print("NextVideo");
//     //
//     // }
//     audioHandler.stop();
//     Constants.isShowAudioPlayer = false;
//     Constants.liveRadioPlaying = false;
//     Constants.isShowVideoPlayer = true;
//     Constants.isAudioPlayerOpen = true;
//     betterPlayerConfiguration =
//         BetterPlayerConfiguration(
//             aspectRatio: 3 / 2,autoDispose: true, deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//             fit: BoxFit.contain, autoPlay: true,autoDetectFullscreenDeviceOrientation: false,controlsConfiguration: BetterPlayerControlsConfiguration(enableOverflowMenu: false, enableProgressText: true, enablePip: true, enableProgressBarDrag: true,enableSkips:false,enableProgressBar: true,enableFullscreen: false,overflowMenuIconsColor: Colors.transparent,showControls: false)
//         );
//     dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       data.url,
//       videoFormat: BetterPlayerVideoFormat.hls,
//       liveStream: true,notificationConfiguration: BetterPlayerNotificationConfiguration(
//       showNotification: true,
//
//       title: data.name,
//       author: "Dj Angel S",
//       imageUrl: data.image,
//     ),
//     );
//
//     playerController = BetterPlayerController(betterPlayerConfiguration);
//     playerController.setBetterPlayerGlobalKey(playerKey);
//     playerController.setupDataSource(dataSource);
//     VideoPlayerManager.playerController.setControlsEnabled(true);
//
//     // if (isNext == true) {
//     //   VideoPlayerManager.playerController.setControlsEnabled(false);
//     //   print("total time");
//     //   print(playerController.videoPlayerController.value.duration);
//     //   print(playerController.videoPlayerController.value.position);
//     //
//     // }
//
//   }
//   // playVideo(Videos data,bool isNext){
//   //   isNextPre = 1;
//   //   if (isNext == true){
//   //
//   //     // playerController.videoPlayerController = null;
//   //     // dataSource = null;
//   //     playerController.videoPlayerController.pause();
//   //     playerController.dispose();
//   //     playerController.videoPlayerController.dispose();
//   //     print("NextVideo");
//   //
//   //   }
//   //   betterPlayerConfiguration =
//   //       BetterPlayerConfiguration(
//   //           aspectRatio: 3 / 2,autoDispose: false, deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//   //           fit: BoxFit.contain, autoPlay: true,autoDetectFullscreenDeviceOrientation: false,controlsConfiguration: BetterPlayerControlsConfiguration(enableOverflowMenu: false, enableProgressText: true, enablePip: true, enableProgressBarDrag: true,enableSkips:false,enableProgressBar: true)
//   //       );
//   //   dataSource = BetterPlayerDataSource(
//   //     BetterPlayerDataSourceType.network, data.url,notificationConfiguration: BetterPlayerNotificationConfiguration(
//   //     showNotification: true,
//   //     title: data.name,
//   //     author: data.categoryNames,
//   //     imageUrl: data.image,
//   //   ),
//   //   );
//   //
//   //   playerController = BetterPlayerController(betterPlayerConfiguration);
//   //   playerController.setBetterPlayerGlobalKey(playerKey);
//   //   playerController.setupDataSource(dataSource);
//   //   VideoPlayerManager.playerController.setControlsEnabled(true);
//   //   if (isNext == true) {
//   //     VideoPlayerManager.playerController.setControlsEnabled(false);
//   //     print("total time");
//   //     print(playerController.videoPlayerController.value.duration);
//   //     print(playerController.videoPlayerController.value.position);
//   //
//   //   }
//   //
//   // }
//
//
//   // static final GlobalKey<BetterPlayerPlaylistState> betterPlayerPlaylistStateKey =
//   // GlobalKey();
//   // static List<BetterPlayerDataSource> dataSourceList = [];
//   // static BetterPlayerConfiguration? betterPlayerConfiguration;
//   // static BetterPlayerPlaylistConfiguration? betterPlayerPlaylistConfiguration;
//   //
//   // static BetterPlayerPlaylistController? get betterPlayerPlaylistController =>
//   //     betterPlayerPlaylistStateKey
//   //         .currentState.betterPlayerPlaylistController;
//   // addPlayList(String urlVideo,String urlImg){
//   //   var list = [
//   //     BetterPlayerDataSource(
//   //       BetterPlayerDataSourceType.network,urlVideo,
//   //       placeholder: Image.network(urlImg,
//   //         fit: BoxFit.contain,
//   //       ),
//   //     )
//   //   ];
//   //   betterPlayerPlaylistController?.setupDataSourceList(list);
//   // }
//   //
//   // clearPlayList(){
//   //   dataSourceList.clear();
//   // }
//   // resumeVideo(){
//   //   betterPlayerPlaylistController.betterPlayerController
//   //       .play();
//   // }
//   // pauseVideo(){
//   //   betterPlayerPlaylistController.betterPlayerController
//   //       .pause();
//   // }
//   // nextVideo(){
//   //   if (betterPlayerPlaylistController.currentDataSourceIndex = (dataSourceList.length - 1)){
//   //     betterPlayerPlaylistController.setupDataSource(betterPlayerPlaylistController.currentDataSourceIndex + 1);
//   //   }else{
//   //     betterPlayerPlaylistController.setupDataSource(0);
//   //   }
//   // }
//   // previousVideo(){
//   //   if (betterPlayerPlaylistController.currentDataSourceIndex = 0){
//   //     betterPlayerPlaylistController.setupDataSource(betterPlayerPlaylistController.currentDataSourceIndex - 1);
//   //   }else{
//   //     betterPlayerPlaylistController.setupDataSource(dataSourceList.length - 1);
//   //   }
//   // }
//   //
//   // playlistPageState() {
//   //   betterPlayerConfiguration = BetterPlayerConfiguration(
//   //     aspectRatio: 1,
//   //     fit: BoxFit.contain,
//   //     placeholderOnTop: true,
//   //     showPlaceholderUntilPlay: true,
//   //     autoPlay: true,
//   //       autoDispose: false,
//   //     subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
//   //     deviceOrientationsAfterFullScreen: [
//   //       DeviceOrientation.portraitUp,
//   //       DeviceOrientation.portraitDown,
//   //     ],
//   //   );
//   //   betterPlayerPlaylistConfiguration = BetterPlayerPlaylistConfiguration(
//   //     loopVideos: true,
//   //     nextVideoDelay: Duration(seconds: 1),
//   //   );
//   // }
//   // Future<List<BetterPlayerDataSource>> setupData() async {
//   //   dataSourceList.add(
//   //     BetterPlayerDataSource(
//   //         BetterPlayerDataSourceType.network, "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
//   //
//   //         // subtitles: BetterPlayerSubtitlesSource.single(
//   //         //   type: BetterPlayerSubtitlesSourceType.values,
//   //         //   url: await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl),
//   //         // ),
//   //         placeholder: Image.network("http://18.213.245.229:3000/assets/images/flow-academy-app.png",
//   //           fit: BoxFit.cover,
//   //         )),
//   //     //     for ( var i in snap.data.notifications )
//   //     // if (i.message == "aa"){
//   //     //   print(i.message);
//   //     // }
//   //   );
//   //
//   //   dataSourceList.add(
//   //     BetterPlayerDataSource(
//   //       BetterPlayerDataSourceType.network, "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
//   //       placeholder: Image.network("http://18.213.245.229:3000/assets/images/flow-academy-app.png",
//   //         fit: BoxFit.cover,
//   //       ),
//   //     ),
//   //   );
//   //   dataSourceList.add(
//   //     BetterPlayerDataSource(
//   //       BetterPlayerDataSourceType.network,
//   //       "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
//   //     ),
//   //
//   //   );
//   //
//   //   return dataSourceList;
//   // }
// }
//
//
//
