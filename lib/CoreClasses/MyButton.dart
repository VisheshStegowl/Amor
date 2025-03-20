import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';

// ignore: must_be_immutable
class CoreButton extends StatefulWidget {
  double width;
  double height;
  Color color;
  String title;
  double radius;
  Color titleColor;
  FontWeight fontWeight;
  double fontSize;

  CoreButton(
      {Key key,
      this.width,
      this.height,
      this.color,
      this.title,
      this.radius,
      this.titleColor,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new CoreButtonState();
  }
}

class CoreButtonState extends State<CoreButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(
            Radius.circular(widget.radius == null ? 15 : widget.radius)),
      ),
      child: Center(
          child: Text(
        widget.title,
        style: TextStyle(
            color: widget.titleColor == null ? white : widget.titleColor,
            fontWeight:
                widget.fontWeight == null ? FontWeight.bold : widget.fontWeight,
            fontSize: widget.fontSize == null ? 15 : widget.fontSize),
      )),
    );
  }
}
