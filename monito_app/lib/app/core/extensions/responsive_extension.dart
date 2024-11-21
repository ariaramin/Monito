// import 'package:flutter/material.dart' show BuildContext, MediaQuery, Size;
//
// enum WindowSizeClass {
//   compact,
//   medium,
//   expanded,
// }
//
// WindowSizeClass _getWindowSizeClass(double width) {
//   if (width >= 1200) {
//     return WindowSizeClass.expanded;
//   } else if (width >= 600 && width < 840) {
//     return WindowSizeClass.medium;
//   } else {
//     return WindowSizeClass.compact;
//   }
// }
//
// extension ResponsiveExtension on BuildContext {
//   double get width => MediaQuery.sizeOf(this).width;
//   double get height => MediaQuery.sizeOf(this).height;
//
//   T responsive<T>(
//     T defaultVal, {
//     T? compact,
//     T? medium,
//     T? expanded,
//   }) {
//     final sizeClass = _getWindowSizeClass(width);
//
//     // Return the correct size class value, falling back in priority order
//     return sizeClass == WindowSizeClass.expanded
//         ? expanded ?? medium ?? compact ?? defaultVal
//         : sizeClass == WindowSizeClass.medium
//             ? medium ?? compact ?? defaultVal
//             : compact ?? defaultVal;
//   }
// }
