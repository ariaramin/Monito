import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'circle_progress_bar_paint.dart';

class CircleProgressBar extends StatefulWidget {
  final Duration? animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? value;

  const CircleProgressBar({
    super.key,
    this.animationDuration = const Duration(seconds: 1),
    this.backgroundColor = const Color(0x00000000),
    required this.foregroundColor,
    this.value = 0,
  });

  @override
  CircleProgressBarState createState() {
    return CircleProgressBarState();
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  late Animation<double> curve;
  late Tween<double>? valueTween;
  Tween<Color?>? backgroundColorTween;
  Tween<Color?>? foregroundColorTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    curve = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    // Build the initial required tweens.
    valueTween = Tween<double>(
      begin: 0,
      end: widget.value,
    );

    _controller!.forward();
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      // Try to start with the previous tween's end value. This ensures that we
      // have a smooth transition from where the previous animation reached.
      double beginValue = valueTween?.evaluate(curve) ?? oldWidget.value!;

      // Update the value tween.
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value,
      );

      // Clear cached color tweens when the color hasn't changed.
      if (oldWidget.backgroundColor != widget.backgroundColor) {
        backgroundColorTween = ColorTween(
          begin: oldWidget.backgroundColor,
          end: widget.backgroundColor,
        );
      } else {
        backgroundColorTween = null;
      }

      if (oldWidget.foregroundColor != widget.foregroundColor) {
        foregroundColorTween = ColorTween(
          begin: oldWidget.foregroundColor,
          end: widget.foregroundColor,
        );
      } else {
        foregroundColorTween = null;
      }

      _controller!
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: curve,
        child: Container(),
        builder: (context, child) {
          final backgroundColor =
              backgroundColorTween?.evaluate(curve) ?? widget.backgroundColor;
          final foregroundColor =
              foregroundColorTween?.evaluate(curve) ?? widget.foregroundColor;

          return CustomPaint(
            foregroundPainter: CircleProgressBarPainter(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              percentage: valueTween!.evaluate(curve),
              strokeWidth: 4.r,
            ),
            child: child,
          );
        },
      ),
    );
  }
}
