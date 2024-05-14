import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Color(0xffC6E619),
        secondary: Color(0xff60E619),
        tertiary: Colors.grey[800],
        inversePrimary: Colors.grey.shade700),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.grey[700],
          displayColor: Colors.black,
        ));

//brown #E69F19
//green #60E619
//lime #C6E619
//biru Color(0xff3919E6)