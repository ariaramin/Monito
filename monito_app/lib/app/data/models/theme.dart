import 'package:flutter/material.dart' show ThemeData;

class ThemeModel {
  final int id;
  final String title;
  final ThemeData data;

  ThemeModel({
    required this.id,
    required this.title,
    required this.data,
  });
}
