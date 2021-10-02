import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class FaceboookButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;

  FaceboookButton({Key key, VoidCallback onPressed, String text})
      : _onPressed = onPressed,
        _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.facebookColor,
      textColor: AppColors.white,
      padding: EdgeInsets.only(top: 11.5, bottom: 11.5),
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
