import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onPress;
  final String buttonName;
  final IconData iconName;
  final Color buttonBgColors;
  final Color textColor;
  final Color iconColor;

  const ButtonWidget({
    Key? key,
    required this.onPress,
    required this.buttonName,
    required this.iconName,
    required this.buttonBgColors,
    required this.textColor,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: buttonBgColors, borderRadius: BorderRadius.circular(8.0)),
      width: MediaQuery.sizeOf(context).width,
      child: TextButton.icon(
          onPressed: onPress, icon: Icon(iconName,
      size: 32,color: iconColor,), label: Text(buttonName,
      style:  TextStyle(color: textColor,fontSize: 16.0,fontWeight: FontWeight.w600),)),
    );
  }
}
