import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'Colors.dart';

Widget progressView(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.black.withOpacity(0.1),
    child: Center(
      child: Container(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(appColor),
        ),
      ),
    ),
  );
}

Widget playerProgressView(BuildContext context) {
  return Center(
    child: Container(
      height: 35,
      width: 35,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(pictonBlue),
      ),
    ),
  );
}

Widget loadingIndicator(BuildContext context) {
  return Container(
    height: 20,
    width: 20,
    child: LoadingIndicator(
      indicatorType: Indicator.lineScaleParty,
      colors: [appColor],
      strokeWidth: 2,
    ),
  );
}
