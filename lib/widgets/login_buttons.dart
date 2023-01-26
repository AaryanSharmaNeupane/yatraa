import 'package:flutter/material.dart';

Widget button(context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 5, 91, 8),
            Color.fromARGB(255, 28, 199, 13)
          ]),
    ),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
