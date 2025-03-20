import 'dart:developer';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    Key key,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _chewieController = null;

    super.dispose();
  }

  Future<void> initializePlayer() async {
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      // ..initialize().then((value) {
      //   setState(() {});
      // });
      await Future.wait([
        _videoPlayerController.initialize().then((value) => setState(() {
              _videoPlayerController.play();
            })),
      ]);

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          aspectRatio: null,
          looping: false,
          allowFullScreen: false,
          hideControlsTimer: const Duration(seconds: 1),
          placeholder: Center(
            child: CircularProgressIndicator(
              color: appColor,
              semanticsLabel: 'Loading',
            ),
          ));
      setState(() {});
    } catch (e) {
      initializePlayer();
      log('', name: 'video play error', error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("video player ${widget.videoUrl}");
    return Center(
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: appColor,
                ),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
    );
  }
}
