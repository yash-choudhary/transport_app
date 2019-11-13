import 'package:flutter/material.dart';

class Mycolor {
  static int prA = 22;
  static int prB = 161;
  static int prC = 198;
  static var col = 0xff16A1C6;
  static Map<int, Color> primarycolor =
  {

    50: Color.fromRGBO(prA, prB, prC, .1),
    100: Color.fromRGBO(prA, prB, prC, .2),
    200: Color.fromRGBO(prA, prB, prC, .3),
    300: Color.fromRGBO(prA, prB, prC, .4),
    400: Color.fromRGBO(prA, prB, prC, .5),
    500: Color.fromRGBO(prA, prB, prC, .6),
    600: Color.fromRGBO(prA, prB, prC, .7),
    700: Color.fromRGBO(prA, prB, prC, .8),
    800: Color.fromRGBO(prA, prB, prC, .9),
    900: Color.fromRGBO(prA, prB, prC, 1.0),
  };

  static MaterialColor primaryCustom = MaterialColor(col, primarycolor);
}