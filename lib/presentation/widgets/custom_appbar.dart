import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  final Widget userName;
  List<Widget> actionButton;
  final Widget? leadingWidget;

  MyAppbar(
      {super.key,
      required this.userName,
      required this.actionButton,
      this.leadingWidget});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 100, sigmaY: 200, tileMode: TileMode.mirror),
          child: AppBar(
            leading: leadingWidget ?? const SizedBox(),
            // ignore: prefer_const_constructors
            backgroundColor: Colors.black.withOpacity(0.30),
            title: userName,
            actions: actionButton,
          )),
    );
  }
}
