import 'package:amor_93_7_fm/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';

class SongCategoryCell extends StatelessWidget {
  SongCategoryCell({
    Key key,
    this.onPress,
    this.img,
    this.title,
    this.onPlaylistTap,
  }) : super(key: key);
  final GestureTapCallback onPress;
  final GestureTapCallback onPlaylistTap;
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.black),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  child: Container(
                    color: Colors.black,
                    child: img == ""
                        ? Image.asset(
                            "assets/images/ic_placeholder.png",
                            fit: BoxFit.contain,
                          )
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/images/ic_placeholder.png',
                            image: img,
                            fit: BoxFit.contain,
                          ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.25,
                  )),
              Expanded(
                child: Container(
                  height: Utility(context).height,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        title,
                        style: const TextStyle(color: white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/images/AlbumNext.png",
                  height: 18,
                  width: 35,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
