import 'package:flutter/material.dart';

class BackgroundCurvedView extends StatelessWidget {
  Widget widget;
  BackgroundCurvedView({@required this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height:double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
          ),
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
    ),
    child: widget));
  }
}
