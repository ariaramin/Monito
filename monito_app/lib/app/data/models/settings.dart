import 'package:flutter/material.dart' show IconData;

class Settings {
  final IconData icon;
  final String title;
  final Function() onTap;

  Settings({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
