import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class JihTip extends StatelessWidget {
  final String _imagePath;
  final String _text;

  JihTip({Key key, VoidCallback onPressed, String text, String imagePath})
      : _imagePath = imagePath,
        _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 187,
      decoration: BoxDecoration(gradient: AppColors.jihGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            _imagePath,
            height: 119,
          ),
          Container(
            width: 156,
            child: Text(
              _text,
              style: TextStyle(color: AppColors.white, fontSize: 14.0, fontFamily: "Nunito"),
            ),
          )
        ],
      ),
    );
  }
}
