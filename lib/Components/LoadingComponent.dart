import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "dart:math";

class LoadingComponent extends StatefulWidget {
  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )
      ..repeat()
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        child: Transform.rotate(
          angle: _controller.value * pi,
          child: SvgPicture.asset(
            "assets/svg_icons/loader.svg",
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
