import 'package:flutter/material.dart';

//purple background and white text
class CustomFlatButton1 extends StatelessWidget {
  final width, height, myOnPressed, text, size;
  final double radius;
  final Color textColor, backgroundColor;
  CustomFlatButton1(this.width, this.height, this.text, this.myOnPressed,
      this.size, this.radius, this.textColor, this.backgroundColor);
  build(context) {
    return FlatButton(
      minWidth: width * height / size,
      color: backgroundColor,
      textColor: textColor,
      onPressed: () {
        myOnPressed();
      },
      child: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
