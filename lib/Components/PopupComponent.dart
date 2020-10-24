import 'package:flutter/material.dart';

class PopupComponent extends StatefulWidget {
  final Widget child;
  final Function dismissCallback;

  const PopupComponent({
    Key key,
    this.child,
    this.dismissCallback,
  }) : super(key: key);
  @override
  _PopupComponentState createState() => _PopupComponentState();
}

class _PopupComponentState extends State<PopupComponent>
    with TickerProviderStateMixin {
  //////
  GlobalKey widgetKey = GlobalKey();
  AnimationController _controller;
  AnimationController _colorController;
  Animation<Alignment> _animation;
  Alignment _alignment = Alignment.center;
  bool _dontAnimate = false;
  double _minFlingVelocity = 700;
  double _colorOpacity = .3;

  Future<bool> _animate({begin, end}) async {
    _animation = AlignmentTween(
      begin: begin,
      end: end,
    ).animate(_controller);

    await _controller.forward();
    _dontAnimate = true;
    _controller.reset();
    _dontAnimate = false;
    return Future.value();
  }

  void _onDragStart(DragStartDetails details) {}

  _onDragUpdate(DragUpdateDetails details, height) {
    setState(() {
      final renderBox =
          widgetKey.currentContext.findRenderObject() as RenderBox;

      _alignment = _alignment +
          Alignment(
            0,
            details.delta.dy / ((height - renderBox.size.height) / 2),
          );
    });
  }

  void _onDragEnd(DragEndDetails details) async {
    final velocity = details.velocity.pixelsPerSecond.dy;
    // velocity threshold
    if (velocity.abs() > _minFlingVelocity) {
      // dissmiss upway
      if (velocity.isNegative) {
        await _animate(begin: _alignment, end: Alignment(0, -5));

        // dismiss downway
      } else {
        await _animate(begin: _alignment, end: Alignment(0, 5));
      }

      _colorController.forward();
    } else if (_alignment.y.abs() < 1) {
      _animate(begin: _alignment, end: Alignment.center);
    } else {
      if (_alignment.y.isNegative) {
        await _animate(begin: _alignment, end: Alignment(0, -5));
      } else {
        await _animate(begin: _alignment, end: Alignment(0, 5));
      }
      _colorController.forward();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..addListener(
        () {
          setState(() {
            if (!_dontAnimate) {
              _alignment = _animation.value;
            }
          });
        },
      );

    _colorController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        lowerBound: .5)
      ..addStatusListener(
        (AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            widget.dismissCallback();
          }
        },
      )
      ..addListener(() {
        setState(() {
          _colorOpacity = 1 - _colorController.value;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            alignment: _alignment,
            color: Colors.black.withOpacity(_colorOpacity),
            child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                constraints: BoxConstraints(maxWidth: 326),
                key: widgetKey,
                child: GestureDetector(
                  child: widget.child,
                  onVerticalDragStart: _onDragStart,
                  onVerticalDragUpdate: (DragUpdateDetails update) {
                    _onDragUpdate(update, constraints.maxHeight);
                  },
                  onVerticalDragEnd: _onDragEnd,
                ),
              ),
              builder: (context, child) => child,
            ),
          );
        },
      ),
    );
  }
}
