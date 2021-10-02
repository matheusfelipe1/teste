import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:joinder_app/app/shared/widgets/confirmation_dialog.dart';
import 'package:joinder_app/app/shared/widgets/default_dialog_chat.dart';
import 'package:joinder_app/app/shared/widgets/default_dialog_profile.dart';
import 'package:joinder_app/app/shared/widgets/options_config_dialog.dart';
import 'package:joinder_app/app/shared/widgets/options_dialog.dart';
import 'package:joinder_app/app/shared/widgets/want_to_do_dialog.dart';
import 'package:package_info/package_info.dart';

import 'package:joinder_app/app/shared/models/profile.dart';

import 'package:joinder_app/app/shared/widgets/default_dialog.dart';
import 'package:joinder_app/app/shared/widgets/dialog_activate_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static String getSign(Profile profile) {
    if (profile.sign != null && profile.sign.sunSign != null) {
      switch (profile.sign.sunSign) {
        case "Aries":
          return "Áries";
        case "Taurus":
          return "Touro";
        case "Gemini":
          return "Gêmeos";
        case "Cancer":
          return "Câncer";
        case "Leo":
          return "Leão";
        case "Virgo":
          return "Virgem";
        case "Libra":
          return "Libra";
        case "Scorpio":
          return "Escorpião";
        case "Sagittarius":
          return "Sagitário";
        case "Capricorn":
          return "Capricórnio";
        case "Aquarius":
          return "Aquário";
        case "Pisces":
          return "Peixes";
        default:
          return profile.sign.sunSign;
      }
    } else
      return "";
  }

  static String getSignImage(Profile profile) {
    if (profile.sign != null && profile.sign.sunSign != null) {
      switch (profile.sign.sunSign) {
        case "Aries":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_aries.jpg?alt=media&token=c5287bc9-62aa-4fcb-afb4-fdac45ec3e50";
        case "Taurus":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_touro.jpg?alt=media&token=0eb3949b-5105-43b0-9db7-5c205d718ecd";
        case "Gemini":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_gemeos.jpg?alt=media&token=1ff460d9-c677-4043-9ea4-854ce985bee5";
        case "Cancer":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_cancer.jpg?alt=media&token=6be8eb9a-4130-455f-9ce6-c361cf656c43";
        case "Leo":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_leao.jpg?alt=media&token=1adff69e-c3df-4b99-a0ed-4599b380d2e5";
        case "Virgo":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_virgem.jpg?alt=media&token=57f6918d-58af-492e-a7cd-ecae263ea975";
        case "Libra":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_libra.jpg?alt=media&token=d8a2cadf-6501-4868-8ad1-c1a609a52c1a";
        case "Scorpio":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_escorpiao.jpg?alt=media&token=5d75216f-387b-4998-8e23-3083fd9c4125";
        case "Sagittarius":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_sagitario.jpg?alt=media&token=a81f1e8c-5c25-42c0-82bb-c7a2dc04d476";
        case "Capricorn":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_capricornio.jpg?alt=media&token=6d079430-d31b-4551-8315-e271b2c1a2ac";
        case "Aquarius":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_aquario.jpg?alt=media&token=3e8a4c0d-8741-4896-a89e-433144debf6d";
        case "Pisces":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_peixes.jpg?alt=media&token=92f9578b-413a-43ac-9d96-89b3518e51f0";
        default:
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_peixes.jpg?alt=media&token=92f9578b-413a-43ac-9d96-89b3518e51f0";
      }
    } else
      return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_peixes.jpg?alt=media&token=92f9578b-413a-43ac-9d96-89b3518e51f0";
  }

  static String getSignImageCard(String sign) {
    if (sign != null) {
      switch (sign) {
        case "Aries":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_aries.jpg?alt=media&token=c5287bc9-62aa-4fcb-afb4-fdac45ec3e50";
        case "Taurus":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_touro.jpg?alt=media&token=0eb3949b-5105-43b0-9db7-5c205d718ecd";
        case "Gemini":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_gemeos.jpg?alt=media&token=1ff460d9-c677-4043-9ea4-854ce985bee5";
        case "Cancer":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_cancer.jpg?alt=media&token=6be8eb9a-4130-455f-9ce6-c361cf656c43";
        case "Leo":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_leao.jpg?alt=media&token=1adff69e-c3df-4b99-a0ed-4599b380d2e5";
        case "Virgo":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_virgem.jpg?alt=media&token=57f6918d-58af-492e-a7cd-ecae263ea975";
        case "Libra":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_libra.jpg?alt=media&token=d8a2cadf-6501-4868-8ad1-c1a609a52c1a";
        case "Scorpio":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_escorpiao.jpg?alt=media&token=5d75216f-387b-4998-8e23-3083fd9c4125";
        case "Sagittarius":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_sagitario.jpg?alt=media&token=a81f1e8c-5c25-42c0-82bb-c7a2dc04d476";
        case "Capricorn":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_capricornio.jpg?alt=media&token=6d079430-d31b-4551-8315-e271b2c1a2ac";
        case "Aquarius":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_aquario.jpg?alt=media&token=3e8a4c0d-8741-4896-a89e-433144debf6d";
        case "Pisces":
          return "https://firebasestorage.googleapis.com/v0/b/joinder.appspot.com/o/Signos%2Fim_peixes.jpg?alt=media&token=92f9578b-413a-43ac-9d96-89b3518e51f0";
        default:
          return "http://lorempixel.com/400/400/sports/";
      }
    } else
      return "http://lorempixel.com/400/400/sports/";
  }

  static String getSignCard(String sign) {
    if (sign != null) {
      switch (sign) {
        case "Aries":
          return "Áries";
        case "Taurus":
          return "Touro";
        case "Gemini":
          return "Gêmeos";
        case "Cancer":
          return "Câncer";
        case "Leo":
          return "Leão";
        case "Virgo":
          return "Virgem";
        case "Libra":
          return "Libra";
        case "Scorpio":
          return "Escorpião";
        case "Sagittarius":
          return "Sagitário";
        case "Capricorn":
          return "Capricórnio";
        case "Aquarius":
          return "Aquário";
        case "Pisces":
          return "Peixes";
        default:
          return sign;
      }
    } else
      return "";
  }

  static String getSignIcon(String sign) {
    switch (sign) {
      case 'Áries':
        return 'assets/images/aries_icone.png';
      case 'Touro':
        return 'assets/images/touro_icone.png';
      case 'Gêmeos':
        return 'assets/images/gemeos_icone.png';
      case 'Câncer':
        return 'assets/images/cancer_icone.png';
      case 'Leão':
        return 'assets/images/leao_icone.png';
      case 'Virgem':
        return 'assets/images/virgem_icone.png';
      case 'Libra':
        return 'assets/images/libra_icone.png';
      case 'Escorpião':
        return 'assets/images/escorpiao_icone.png';
      case 'Sagitário':
        return 'assets/images/sagitario_icone.png';
      case 'Capricórnio':
        return 'assets/images/capricornio_icone.png';
      case 'Aquário':
        return 'assets/images/aquario_icone.png';
      case 'Peixes':
        return 'assets/images/peixes_icone.png';
      default:
        return 'assets/images/aries_icone.png';
    }
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}";
  }

  static Future<bool> asyncConfirmDialog(
      BuildContext context,
      String image,
      String title,
      String subtitle,
      String description,
      String negativeButton,
      String confirmationButton) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmationDialog(
        image: image,
        titleBold: title,
        titleGray: subtitle,
        titleDesc: description,
        negativeText: negativeButton,
        confirmationText: confirmationButton,
        hasButton: true,
      ),
    );
  }

  static Future<void> defaultDialog(BuildContext context, bool isNegative,
      String title, String description, bool hasButton,
      {String buttonText, double sizeTitle}) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DefaultDialog(
        title: title,
        sizeTitle: sizeTitle,
        description: description,
        hasButton: true,
        isNegative: isNegative,
        buttonText: buttonText != null ? buttonText : null,
      ),
    );
  }

  static Future<void> dialogActivateAccount(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogActivateAccount(),
    );
  }

  static Future<void> defaultDialogChat(
      BuildContext context,
      String textBold,
      String textPurple,
      bool textFooter,
      bool ice,
      String image,
      String description,
      bool hasButton,
      {String buttonText}) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DefaultDialogChat(
        textBold: textBold,
        textPurple: textPurple,
        textFooter: textFooter,
        ice: ice,
        image: image,
        description: description,
        hasButton: true,
        buttonText: buttonText != null ? buttonText : null,
      ),
    );
  }

  static Future<dynamic> defaultDialogProfile(BuildContext context,
      String contentBody, dynamic list, dynamic selectedList) async {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DefaultDialogProfile(
          contentBody: contentBody, list: list, selectedList: selectedList),
    );
  }

  static Future<dynamic> wantToDoDialog(BuildContext context) async {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WantToDoDialog(),
    );
  }

  static Future<String> optionsDialog(BuildContext context, bool hasButton,
      {String buttonText,
      String image,
      String titleCustom,
      String titlePurple,
      String titleBold,
      bool ice}) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => OptionsDialog(
        image: image,
        titleCustom: titleCustom,
        titlePurple: titlePurple,
        titleBold: titleBold,
        ice: ice != false ? ice : false,
        hasButton: true,
        buttonText: buttonText != null ? buttonText : null,
      ),
    );
  }

  static Future<String> optionsConfigDialog(
      BuildContext context, bool hasButton,
      {String buttonText,
      String image,
      String titleCustom,
      String titlePurple,
      String titleObs,
      String titleBold}) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => OptionsConfigDialog(
        image: image,
        titleCustom: titleCustom,
        titlePurple: titlePurple,
        titleBold: titleBold,
        titleObs: titleObs,
        hasButton: true,
        buttonText: buttonText != null ? buttonText : null,
      ),
    );
  }

  static Future<Map<String, dynamic>> getObjectFromStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final string = prefs.getString(key);
    return string != null ? jsonDecode(string) : null;
  }

  static Future<bool> saveObjectOnStorage(
      String key, Map<String, dynamic> json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, jsonEncode(json));
  }

  static Future<bool> removeObjectFromStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static String getIconsToWayOfLove(typeWayOfLove, color) {
    List<String> icons = ['', ''];
    switch (typeWayOfLove) {
      case 'affirming_words':
        icons[0] = 'assets/images/ic_palavras_roxo.png';
        icons[1] = 'assets/images/ic_palavras_cinza.png';
        break;
      case 'time':
        icons[0] = 'assets/images/ic_tempo_roxo.png';
        icons[1] = 'assets/images/ic_tempo_cinza.png';

        break;
      case 'gifts':
        icons[0] = 'assets/images/ic_presente_roxo.png';
        icons[1] = 'assets/images/ic_presente_cinza.png';
        break;
      case 'touch':
        icons[0] = 'assets/images/ic_toque_roxo.png';
        icons[1] = 'assets/images/ic_toque_cinza.png';
        break;
      case 'service':
        icons[0] = 'assets/images/ic_gestos_roxo.png';
        icons[1] = 'assets/images/ic_gestos_cinza.png';
        break;
      default:
        icons[0] = 'assets/images/ic_gestos_roxo.png';
        icons[1] = 'assets/images/ic_gestos_cinza.png';
        break;
    }
    if (color == 'roxo') {
      return icons[0];
    } else {
      return icons[1];
    }
  }

// MARK: Utils
  static textWithFirstLetterUppercase(String text) {
    List arrayWords = text.toString().split(' ');
    String textFormatted = '';
    for (var i = 0; i < arrayWords.length; i++) {
      String espacamento = i != 0 ? ' ' : '';
      textFormatted += espacamento +
          arrayWords[i][0].toUpperCase() +
          arrayWords[i].substring(1);
    }
    return textFormatted;
  }
}
