import 'package:flutter/material.dart';

Widget title(context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: '𝓨',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).primaryColor,
        ),
        children: [
          const TextSpan(
            text: '𝓪𝓽𝓻',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: '𝓪𝓪',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
            ),
          ),
        ]),
  );
}
