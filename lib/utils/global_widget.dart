import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GlobalWidget {
  static showLoading({required BuildContext context}) {
    return Center(
        child: SizedBox(
            height: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              color: Theme.of(context).primaryColor,
            )));
  }

  static TextStyle buildTextStyle() => TextStyle(fontSize: 18);
}
