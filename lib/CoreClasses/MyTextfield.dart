import 'package:flutter/material.dart';
import 'package:amor_93_7_fm/Utility/Colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  String topPlaceholer;
  String hintText;
  TextInputType textInputType;
  bool secureText;
  Widget suffixIcon;
  Function(String) onChanged;
  TextEditingController controller;
  double height;
  int maxLength;
  bool enable;
  MyTextField(
      {Key key,
      this.controller,
      this.enable,
      this.maxLength,
      this.height,
      this.topPlaceholer,
      this.hintText,
      this.textInputType,
      this.secureText,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MyTextFieldState();
  }
}

class MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appGray.shade900,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      height: widget.height == null ? 70 : widget.height,
      width: MediaQuery.of(context).size.width - 60,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: Row(
              children: [
                Text(
                  widget.topPlaceholer.toUpperCase(),
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
            child: TextField(
              cursorColor: white,
              controller: widget.controller,
              obscureText: widget.secureText,
              onChanged: widget.onChanged,
              keyboardType: widget.textInputType,
              maxLength: widget.maxLength,
              enabled: widget.enable == null ? true : widget.enable,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle:
                      TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints:
                      BoxConstraints(maxHeight: 20, maxWidth: 30)),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
