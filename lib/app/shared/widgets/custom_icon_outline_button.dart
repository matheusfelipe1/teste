import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class CustomIconOutlineButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final IconData _icon;

  CustomIconOutlineButton(
      {Key key, VoidCallback onPressed, String text, IconData icon})
      : _onPressed = onPressed,
        _text = text,
        _icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: AppColors.outlineButtonBorder, width: 2.0),
      highlightedBorderColor: AppColors.outlineButtonBorder,
      highlightColor: AppColors.support3,
      color: AppColors.white,
      padding: EdgeInsets.only(top: 8, bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: _onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(
              _icon,
              color: AppColors.firstFont,
            ),
          ),
          Text(
            _text,
            style: TextStyle(
                color: AppColors.firstFont,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                fontSize: 11.0),
          )
        ],
      ),
    );
  }
}
