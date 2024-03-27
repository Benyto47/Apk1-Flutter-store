import 'dart:ffi';

import 'package:flutter/material.dart';

class Textwidget extends StatelessWidget {
   Textwidget({super.key, required this.text, required this.color, required this.textSizes, this.isTitle = false, this.maxLines = 10});

  final String text;
  final Color color;
  final double textSizes;
  bool isTitle;
  int maxLines = 10;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: textSizes,
          fontWeight: isTitle? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      );
  }
}