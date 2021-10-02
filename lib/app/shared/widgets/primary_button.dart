import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final EdgeInsets _padding;

  PrimaryButton(
      {Key key, VoidCallback onPressed, String text, EdgeInsets padding})
      : _onPressed = onPressed,
        _text = text,
        _padding = padding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.purple,
      textColor: AppColors.white,
      padding: _padding == null
          ? EdgeInsets.only(top: 11.5, bottom: 11.5)
          : _padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(
            color: AppColors.white,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            fontSize: 11.0),
      ),
    );
  }
}
