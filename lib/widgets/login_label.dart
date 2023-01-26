import 'package:flutter/material.dart';

Widget label(context, String acc, String btn) {
  return Container(
    padding: const EdgeInsets.all(15),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          acc,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          btn,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
