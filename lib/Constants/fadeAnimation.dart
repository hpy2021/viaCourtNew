import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTween([
    //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);
    // final tween = MultiTrackTween(  Duration(milliseconds: 500),[],0.5);

    return CustomAnimation<double>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration:Duration(milliseconds: 500) ,
      curve: Curves.easeOut,

      tween: Tween(begin: 0.0, end: 1.0),
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation,
        child: Transform.translate(
            offset: Offset(animation,0), child: child),
      ),
    );
  }
}
