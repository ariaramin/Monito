import 'package:flutter/material.dart'
    show AlignmentDirectional, Color, RadialGradient;

class AppGradients {
  static const blueGradient = RadialGradient(
    center: AlignmentDirectional.topStart,
    radius: 1.7,
    colors: [
      Color(0xff1D4ED8),
      Color(0xff1E3A8A),
    ],
  );

  static const orangeGradient = RadialGradient(
    center: AlignmentDirectional.topStart,
    radius: 1.7,
    colors: [
      Color(0xffED8D47),
      Color(0xffEB3D60),
    ],
  );

  static const purpleGradient = RadialGradient(
    center: AlignmentDirectional.topStart,
    radius: 1.7,
    colors: [
      Color(0xff9633E8),
      Color(0xff6529EB),
    ],
  );
}
