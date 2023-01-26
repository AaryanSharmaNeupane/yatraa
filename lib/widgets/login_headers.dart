import 'package:flutter/material.dart';

Widget header(String title) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
