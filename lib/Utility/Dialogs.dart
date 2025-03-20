import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CommanString.dart';

enum ActionStyle { normal, destructive, important, important_destructive }

class Dialogs {

  static Color _normal = Colors.black;
  static Color _destructive = Colors.red;

  /// show the OS Native dialog
  static showOSDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallBack,
      {ActionStyle firstActionStyle = ActionStyle.normal,
        String secondButtonText,
        Function secondCallback,
        ActionStyle secondActionStyle = ActionStyle.normal}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return _iosDialog(
              context, title, message, firstButtonText, firstCallBack,
              firstActionStyle: firstActionStyle,
              secondButtonText: secondButtonText,
              secondCallback: secondCallback,
              secondActionStyle: secondActionStyle);
        } else {
          return _androidDialog(
              context, title, message, firstButtonText, firstCallBack,
              firstActionStyle: firstActionStyle,
              secondButtonText: secondButtonText,
              secondCallback: secondCallback,
              secondActionStyle: secondActionStyle);
        }
      },
    );
  }

  /// show the android Native dialog
  static Widget _androidDialog(BuildContext context, String title,
      String message, String firstButtonText, Function firstCallBack,
      {ActionStyle firstActionStyle = ActionStyle.normal,
        String secondButtonText,
        Function secondCallback,
        ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<InkWell> actions = [];
    actions.add(InkWell(
      child: Text(
        firstButtonText,
        style: TextStyle(
            color: (firstActionStyle == ActionStyle.important_destructive ||
                firstActionStyle == ActionStyle.destructive)
                ? _destructive
                : _normal,
            fontWeight:
            (firstActionStyle == ActionStyle.important_destructive ||
                firstActionStyle == ActionStyle.important)
                ? FontWeight.bold
                : FontWeight.normal),
      ),
      onTap: () {
        Navigator.of(context).pop();
        firstCallBack();
      },
    ));

    if (secondButtonText != null) {
      // ignore: deprecated_member_use
      actions.add(InkWell(
        child: Text(secondButtonText,
            style: TextStyle(
                color:
                (secondActionStyle == ActionStyle.important_destructive ||
                    firstActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal)),
        onTap: () {
          Navigator.of(context).pop();
          secondCallback();
        },
      ));
    }

    return AlertDialog(
        title: Text(title), content: Text(message), actions: actions);
  }

  /// show the iOS Native dialog
  static Widget _iosDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallback,
      {ActionStyle firstActionStyle = ActionStyle.normal,
        String secondButtonText,
        Function secondCallback,
        ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<CupertinoDialogAction> actions = [];
    actions.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop();
          firstCallback();
        },
        child: Text(firstButtonText,
          style: TextStyle(
              color: (firstActionStyle == ActionStyle.important_destructive ||
                  firstActionStyle == ActionStyle.destructive)
                  ? _destructive
                  : _normal,
              fontWeight:
              (firstActionStyle == ActionStyle.important_destructive ||
                  firstActionStyle == ActionStyle.important)
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ),
    );

    if (secondButtonText != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            secondCallback();
          },
          child: Text(secondButtonText,
            style: TextStyle(
                color: (secondActionStyle == ActionStyle.important_destructive ||
                    secondActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal,
                fontWeight:
                (secondActionStyle == ActionStyle.important_destructive ||
                    secondActionStyle == ActionStyle.important)
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ),
      );
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );
  }


  static showActionSheetWithImgPickerView(BuildContext context, Function cameraCallback, Function albumCallback) {
    final action = CupertinoActionSheet(
      title: Text(
        "Image Selection",
        style: TextStyle(fontSize: 15),
      ),
      message: Text(
        "From where you want to pick this image?",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(camera),
          isDefaultAction: true,
          onPressed: () => {
            cameraCallback()
          },
        ),
        CupertinoActionSheetAction(
          child: Text(photoAlbum),
          isDefaultAction: true,
          onPressed: () =>{
            albumCallback()
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel", style: TextStyle(color: Colors.red),),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(
        context: context, builder: (context) => action);
  }
}
class NormalAlert {

  static showAlertDialog(BuildContext context,String title,String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
