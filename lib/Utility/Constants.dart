import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/Model/CMSModel.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Model/AppUserModel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';

import 'Colors.dart';

int isPlay = 0;
final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
VideoPlayerController videoController;
CMSModel cmsData;
Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath,
      orElse: () => null);
}

List<Audio> MySongList = [];
Playlist playlist;
int songCount = 0;
InterstitialAd interstitialAd;

class Constants {
  static var isAudioPlayerOpen = false;
  static var showBottomPlayerHeight = isShowVideoPlayer ? 103.0 : 140.0;
  static var isShowIcons = true;
  static var hideBottomPlayerHeight = 28.0;
  static var isShowAudioPlayer = false;
  static var isShowVideoPlayer = false;
  // static var isShowVideoPlayer = false;
  static var isRepeat = false;
  static var isSuffle = false;
  static var fmcToken = "";
  static bool liveRadioPlaying = false;
  static AppUserModel userModel;
  static const String placeholderText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'
      ' tempor incididunt ut labore et dolore magna aliqua. Faucibus purus in'
      ' massa tempor. Quis enim lobortis scelerisque fermentum dui faucibus'
      ' in. Nibh praesent tristique magna sit amet purus gravida quis.'
      ' Magna sit amet purus gravida quis blandit turpis cursus in. Sed'
      ' adipiscing diam donec adipiscing tristique. Urna porttitor rhoncus'
      ' dolor purus non enim praesent. Pellentesque habitant morbi tristique'
      ' senectus et netus. Risus ultricies tristique nulla aliquet enim tortor'
      ' at.';
// static RadioMenuData radioMenuDat  a = RadioMenuData();
  // static List<SongData> songArray = [];
}

class Utility {
  BuildContext context;
  Utility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhoneNumber() {
    if (this == null || this.isEmpty) {
      return false;
    }
    const pattern = r'^(?:[+0]9)?[0-9]{10}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }
}

extension d on Duration {
  String durationToString() {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitMinutes =
        twoDigits(this.inMinutes.remainder(Duration.minutesPerHour));
    final twoDigitSeconds =
        twoDigits(this.inSeconds.remainder(Duration.secondsPerMinute));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}

String durationToStringTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    this.duration,
    this.position,
    this.bufferedPosition = Duration.zero,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;
  bool _dragging = false;
  SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      activeTrackColor: appColor,
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return SizedBox(
      height: 10,
      width: Utility(context).width,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2.0,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          thumbColor: appColor,
          activeTrackColor: appColor,
          inactiveTrackColor: white,
        ),
        child: Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: value,
          onChanged: (value) {
            if (!_dragging) {
              _dragging = true;
            }
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragging = false;
          },
        ),
      ),
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
