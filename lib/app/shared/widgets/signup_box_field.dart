import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class SignUpBoxField extends StatelessWidget {
  final TextEditingController _controller;
  final bool _autovalidate;
  final bool _obscureText;
  final bool _autocorrect;
  final bool _enable;
  final String _hintText;
  final int _maxLines;
  final Color _background;
  final bool _autofocus;
  final Color _colorFont;
  final EdgeInsets _contentPadding;
  final TextInputType _keyboardType;
  final Function(String) _validator;
  final Function(String) _onChanged;

  SignUpBoxField({
    Key key,
    TextEditingController controller,
    bool autovalidate,
    bool obscureText,
    bool autocorrect,
    String hintText,
    int maxLines,
    bool autofocus,
    bool enable,
    Color colorFont,
    Color background,
    EdgeInsets contentPadding,
    TextInputType keyboardType,
    Function(String) validator,
    Function(String) onChanged,
  })  : _controller = controller,
        _autovalidate = autovalidate,
        _autofocus = autofocus,
        _autocorrect = autocorrect,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _hintText = hintText,
        _validator = validator,
        _background = background,
        _maxLines = maxLines,
        _enable = enable,
        _onChanged = onChanged,
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
      onChanged: _onChanged,
      obscureText: _obscureText,
      maxLength: 500,
      autofocus: _autofocus,
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
      style: TextStyle(color: _colorFont, fontSize: 14.0, fontFamily: 'Nunito'),
    );
  }
}
