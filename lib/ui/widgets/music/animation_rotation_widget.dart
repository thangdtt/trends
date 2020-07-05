import 'package:flutter/material.dart';

class AnimationRotationWidget extends StatefulWidget {
  const AnimationRotationWidget({Key key, this.play, this.child})
      : super(key: key);

  @override
  _AnimationRotationWidgetState createState() =>
      _AnimationRotationWidgetState();
  final bool play;
  final Widget child;
}

class _AnimationRotationWidgetState extends State<AnimationRotationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    if (widget.play) {
      _controller.forward();
    }
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(AnimationRotationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.forward();
      } else {
        _controller.stop(canceled: false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: widget.child,
    );
  }
}
