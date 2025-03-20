import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoreImage extends StatefulWidget {
  BorderRadius borderRadius;
  double height;
  double width;
  String url;
  BoxFit boxFit;
  bool isPlaceHolder;

  CoreImage({Key key, this.borderRadius, this.width, this.height, this.url, this.boxFit, this.isPlaceHolder}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new CoreImageState();
  }
}

class CoreImageState extends State<CoreImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: widget.borderRadius,
        child: widget.url != "" ? FadeInImage.assetNetwork(
          placeholder: widget.isPlaceHolder == null ? 'assets/images/ic_placeholder.png' : 'assets/images/ic_placeholder.png',
          image: widget.url,
          height: widget.height,
          width: widget.width,
          fit: widget.boxFit,) :  Image.asset('assets/images/ic_placeholder.png',
          height: widget.height,
          width: widget.width,
          fit: widget.boxFit,
        ));
  }
}
