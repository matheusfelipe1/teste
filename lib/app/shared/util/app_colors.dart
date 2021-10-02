import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static Color purple = Color.fromRGBO(134, 41, 138, 1);
  static Color darkPurple = Color.fromRGBO(90, 33, 94, 1);
  static Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color facebookColor = Color.fromRGBO(46, 95, 197, 1);
  static Color dialogBox = Color.fromRGBO(246, 244, 248, 1);
  static Color error = Color.fromRGBO(221, 78, 76, 1);

  static Color backgroundBlueLocation = Color.fromRGBO(118, 111, 177, 1);

  // Fonts
  static Color firstFont = Color.fromRGBO(154, 40, 161, 1);
  static Color secondFont = Color.fromRGBO(155, 131, 165, 1);
  static Color thirthFont = Color.fromRGBO(156, 151, 162, 1);
  static Color fourthFont = Color.fromRGBO(154, 40, 161, 1);
  static Color mainFont = Color.fromRGBO(91, 77, 97, 1);
  static Color mainFontOpacity9 = Color.fromRGBO(91, 77, 97, 0.9);
  static Color mainFontOpacity4 = Color.fromRGBO(91, 77, 97, 0.4);
  static Color mainFontOpacity01 = Color.fromRGBO(91, 77, 97, 0.01);
  static Color thirthMain = Color.fromRGBO(90, 33, 94, 1);
  static Color fontGrayLight = Color.fromRGBO(156, 151, 162, 1);
  static Color fontLink = Color.fromRGBO(53, 166, 233, 1);
  static Color blackOpacity25 = Color.fromRGBO(0, 0, 0, 0.25);
  static Color fontMessageListChat = Color.fromRGBO(238, 31, 112, 1);
  static Color fontOptionsDialog = Color.fromRGBO(156, 151, 162, 0.9);
  static Color backgroundYellow = Color.fromRGBO(251, 194, 49, 1);
  static Color backgroundRed = Color.fromRGBO(235, 87, 87, 1);
  static Color backgroundGreen = Color.fromRGBO(39, 165, 44, 1);

  // Forms
  static Color formBorder = Color.fromRGBO(233, 221, 232, 1);
  static Color formBackground = Color.fromRGBO(251, 248, 255, 1);
  static Color formHint = Color.fromRGBO(112, 112, 112, 1);

  //Background
  static Color backgroundChat = Color.fromRGBO(241, 237, 246, 1);
  static Color backgroundChatOptions = Color.fromRGBO(229, 229, 229, 1);
  static Color backgroundDialog = Color.fromRGBO(26, 3, 34, 0.8);
  static Color backgroundSlider = Color.fromRGBO(251, 30, 105, 1);
  static Color backgroundYellowMsg = Color.fromRGBO(251, 194, 49, 1);
  static Color backgroundRedMsg = Color.fromRGBO(235, 87, 87, 1);

  // Borders
  static Color mainBorder = Color.fromRGBO(255, 214, 230, 1);
  static Color mainBorderOpacity7 = Color.fromRGBO(255, 214, 230, 0.7);
  static Color outlineButtonBorder = Color.fromRGBO(246, 214, 255, 1);
  static Color selectedBorder = Color.fromRGBO(214, 144, 207, 1);
  static Color dividerBorder = Color.fromRGBO(220, 214, 230, 1);
  static Color dividerBorderOpacity59 = Color.fromRGBO(220, 214, 230, 0.59);
  static Color dividerBorderVertical = Color.fromRGBO(213, 213, 213, 1);

  // Buttons
  static Color support1 = Color.fromRGBO(245, 231, 255, 1);
  static Color support2 = Color.fromRGBO(196, 185, 212, 1);
  static Color support3 = Color.fromRGBO(247, 244, 248, 1);

  // Signs
  static Color ariesColor = Color.fromRGBO(215, 147, 115, 1);
  static Color taurusColor = Color.fromRGBO(211, 126, 150, 1);
  static Color geminiColor = Color.fromRGBO(243, 196, 77, 1);
  static Color cancerColor = Color.fromRGBO(155, 131, 106, 1);
  static Color leoColor = Color.fromRGBO(201, 66, 35, 1);
  static Color virgoColor = Color.fromRGBO(66, 112, 210, 1);
  static Color libraColor = Color.fromRGBO(104, 175, 193, 1);
  static Color scorpioColor = Color.fromRGBO(169, 44, 50, 1);
  static Color sagittariusColor = Color.fromRGBO(118, 111, 177, 1);
  static Color capricornColor = Color.fromRGBO(132, 94, 58, 1);
  static Color aquariusColor = Color.fromRGBO(107, 182, 170, 1);
  static Color piscesColor = Color.fromRGBO(160, 194, 100, 1);

  static Color getSignColor(String sign) {
    switch (sign) {
      case 'Áries':
        return ariesColor;
      case 'Touro':
        return taurusColor;
      case 'Gêmeos':
        return geminiColor;
      case 'Câncer':
        return cancerColor;
      case 'Leão':
        return leoColor;
      case 'Virgem':
        return virgoColor;
      case 'Libra':
        return libraColor;
      case 'Escorpião':
        return scorpioColor;
      case 'Sagitário':
        return sagittariusColor;
      case 'Capricórnio':
        return capricornColor;
      case 'Aquário':
        return aquariusColor;
      case 'Peixes':
        return piscesColor;
      default:
        return piscesColor;
    }
  }

  //Icon
  static Color checkIcon = Color.fromRGBO(67, 186, 204, 1);

  // Gradients
  static Gradient jihGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(255, 179, 151, 1),
        Color.fromRGBO(244, 106, 160, 1)
      ]);

  static Gradient backgroundGradientSlider = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(251, 30, 105, 1),
        Color.fromRGBO(154, 40, 161, 1),
      ]);

  static Gradient deleteChatGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(244, 106, 160, 1),
        Color.fromRGBO(255, 179, 151, 1),
      ]);

  static Gradient configGradient = LinearGradient(
      transform: GradientRotation(3.04159),
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.0144,
        1.2681,
      ],
      colors: <Color>[
        Color.fromRGBO(230, 145, 47, 0.8),
        Color.fromRGBO(255, 83, 157, 1),
      ]);

  static Gradient contentGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(159, 193, 250, 1),
        Color.fromRGBO(244, 106, 160, 1)
      ]);

  static Gradient checkGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(154, 40, 161, 1),
        Color.fromRGBO(251, 30, 105, 1)
      ]);

  static Gradient waysLoveGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(154, 40, 161, 1),
        Color.fromRGBO(251, 30, 105, 1)
      ]);

  static Gradient chatGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(154, 40, 161, 1),
        Color.fromRGBO(251, 30, 105, 1)
      ]);

  static Gradient colorBackgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.repeated,
      // stops: [
      //   -0.0319,
      //   1.0298
      // ],
      colors: [
        Color.fromRGBO(90, 33, 94, 1),
        Color.fromRGBO(152, 205, 255, 1)
      ]);

  static Gradient colorBackgroundFridge = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      stops: [
        -0.0319,
        1.0298
      ],
      colors: [
        Color.fromRGBO(159, 193, 250, 1),
        Color.fromRGBO(158, 102, 230, 1)
      ]);
}
