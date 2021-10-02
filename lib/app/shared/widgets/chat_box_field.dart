import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class ChatBoxField extends StatelessWidget {
  final TextEditingController _controller;
  final bool _autovalidate;
  final bool _obscureText;
  final bool _autocorrect;
  final bool _enable;
  final String _hintText;
  final int _maxLines;
  final Color _background;
  final Color _colorFont;
  final EdgeInsets _contentPadding;
  final TextInputType _keyboardType;
  final Function(String) _validator;

  ChatBoxField(
      {Key key,
      TextEditingController controller,
      bool autovalidate,
      bool obscureText,
      bool autocorrect,
      String hintText,
      int maxLines,
      bool enable,
      Color colorFont,
      Color background,
      EdgeInsets contentPadding,
      TextInputType keyboardType,
      Function(String) validator})
      : _controller = controller,
        _autovalidate = autovalidate,
        _autocorrect = autocorrect,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _hintText = hintText,
        _validator = validator,
        _background = background,
        _maxLines = maxLines,
        _enable = enable,
        _contentPadding = contentPadding,
        _colorFont = colorFont,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autocorrect: _autocorrect,
      autovalidate: _autovalidate,
      keyboardType: _keyboardType,
      validator: _validator,
      enabled: _enable,
      obscureText: _obscureText,
      decoration: InputDecoration(
          contentPadding: _contentPadding,
          hintStyle: TextStyle(
              color: AppColors.formHint, fontSize: 14.0, fontFamily: 'Nunito'),
          hintText: _hintText,
          filled: true,
          fillColor: _background,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: AppColors.formBorder,
                  width: 2.0,
                  style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.formBorder,
                  width: 2.0,
                  style: BorderStyle.solid)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.formBorder,
                  width: 2.0,
                  style: BorderStyle.solid))),
      cursorColor: AppColors.firstFont,
      maxLines: _maxLines,
      onChanged: (text) {
        print("First text field: $text");
      },
      style: TextStyle(color: _colorFont, fontSize: 14.0, fontFamily: 'Nunito'),
    );
  }
}
