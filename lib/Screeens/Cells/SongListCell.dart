import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';
import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/ProgressView.dart';

class SongListCell extends StatefulWidget {
  // ignore: non_constant_identifier_names
  SongListCell(
      {Key key,
      this.SongName,
      this.ArtistName,
      this.SongDuration,
      this.onPress,
      this.onAddPress,
      @required this.SongID})
      : super(key: key);
  // ignore: non_constant_identifier_names
  final String SongID;
  final String SongName;
  // ignore: non_constant_identifier_names
  final String ArtistName;
  // ignore: non_constant_identifier_names
  final String SongDuration;
  Function onPress;
  final GestureTapCallback onAddPress;

  @override
  _SongListCellState createState() => _SongListCellState();
}

class _SongListCellState extends State<SongListCell> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "assets/images/AlbumPlay.png",
        color: appColor,
        height: 30,
        width: 30,
      ),
      title: Text(
        widget.SongName,
        maxLines: 2,
        style: TextStyle(color: white, fontSize: 15),
      ),
      subtitle: Text(
        widget.ArtistName,
        maxLines: 2,
        style: TextStyle(color: Colors.white),
      ),
      dense: true,
      trailing: Wrap(
        spacing: 12,
        children: [
          StreamBuilder<RealtimePlayingInfos>(
              stream: assetsAudioPlayer.realtimePlayingInfos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.current != null) {
                    if (snapshot.data.current.audio.audio.metas.id ==
                        widget.SongID) {
                      return StreamBuilder<bool>(
                          stream: assetsAudioPlayer.isPlaying,
                          builder: (context, snapshot) {
                            final playbackState = snapshot.data;
                            if (snapshot.hasData) {
                              if (playbackState) {
                                return loadingIndicator(context);
                              }
                              return SizedBox(
                                width: 0,
                                height: 0,
                              );
                            } else {
                              return SizedBox(
                                width: 0,
                                height: 0,
                              );
                            }
                          });
                    } else {
                      return SizedBox(
                        width: 0,
                        height: 0,
                      );
                    }
                  } else {
                    return SizedBox(
                      width: 0,
                      height: 0,
                    );
                  }
                } else {
                  return SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
              }),
          Text(
            widget.SongDuration,
            style: TextStyle(color: Colors.white),
          ),
          InkWell(
            onTap: widget.onAddPress,
            child: Image.asset(
              "assets/images/AlbumAdd.png",
              // color: Colors.white,
              // colorBlendMode: BlendMode.clear,
              height: 20,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
