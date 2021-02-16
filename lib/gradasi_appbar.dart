import 'package:flutter/material.dart';

class GradasiAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff0096ff), Color(0xffe040fb)],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight),
      ),
    );
  }
}
