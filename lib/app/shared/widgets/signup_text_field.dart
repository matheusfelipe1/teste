import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class SignUpTextField extends StatelessWidget {
  TextEditingController _controller;
  bool _autovalidate;
  bool _obscureText;
  bool _autocorrect;
  bool _disabled;
  FocusNode _focusNode;
  TextCapitalization _textCapitalization;
  Color _fillColor;
  String _hintText;
  Widget _suffixIcon;
  List<TextInputFormatter> _mask = new List<TextInputFormatter>();
  TextInputType _keyboardType;
  Function(String) _validator;
  Function(String) _onChanged;

  SignUpTextField(
      {TextEditingController controller,
      bool autovalidate,
      bool obscureText,
      bool autocorrect,
      bool disabled,
      FocusNode focusNode,
      TextCapitalization textCapitalization,
      String hintText,
      Color fillColor,
      Widget suffixIcon,
      EdgeInsets padding,
      String mask,
      TextInputType keyboardType,
      Function(String) validator,
      Function(String) onChanged}) {
    _controller = controller;
    _fillColor = fillColor;
    _autovalidate = autovalidate;
    _autocorrect = autocorrect;
    _disabled = disabled != null ? disabled : false;
    _focusNode = focusNode != null ? focusNode : null;
    _textCapitalization = textCapitalization != null ? textCapitalization : TextCapitalization.none;
    _keyboardType = keyboardType;
    _obscureText = obscureText;
    _hintText = hintText;
    _suffixIcon = suffixIcon;
    _onChanged = onChanged;
    if (mask != null && mask != "")
      _mask.add(new MaskTextInputFormatter(mask: mask));
    if (_keyboardType == TextInputType.emailAddress) {
      final filtering = new FilteringTextInputFormatter.deny(RegExp(" "));
      _mask.add(filtering);
    }
    _validator = validator;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      inputFormatters: _mask,
      autocorrect: _autocorrect,
      autovalidate: _autovalidate,
      keyboardType: _keyboardType,
      validator: _validator,
      onChanged: _onChanged,
      obscureText: _obscureText,
      enabled: _disabled ? false : true,
      focusNode: _focusNode,
      textCapitalization: _textCapitalization,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              color: AppColors.formHint, fontSize: 20.0, fontFamily: 'Nunito'),
          hintText: _hintText,
          filled: true,
          suffixIcon: _suffixIcon,
          fillColor: _fillColor == null ? AppColors.support3 : _fillColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: AppColors.formBorder,
                  width: 2.0,
                  style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: AppColors.formBorder,
                  width: 2.0,
                  style: BorderStyle.solid))),
      cursorColor: AppColors.firstFont,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.firstFont,
          fontSize: 28.0,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700),
    );
  }
}
