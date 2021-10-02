import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  TextEditingController _controller;
  bool _autovalidate;
  bool _obscureText;
  bool _autocorrect;
  FocusNode _focusNode;
  Color _fillColor;
  String _hintText;
  List<MaskTextInputFormatter> _mask = new List<MaskTextInputFormatter>();
  TextInputType _keyboardType;
  Function(String) _validator;
  Function(String) _onChanged;

  ProfileTextField(
      {TextEditingController controller,
      bool autovalidate,
      bool obscureText,
      bool autocorrect,
      FocusNode focusNode,
      String hintText,
      Color fillColor,
      EdgeInsets padding,
      String mask,
      TextInputType keyboardType,
      Function(String) validator,
      Function(String) onChanged}) {
    _controller = controller;
    _fillColor = fillColor;
    _autovalidate = autovalidate;
    _autocorrect = autocorrect;
    _focusNode = focusNode != null ? focusNode : null;
    _keyboardType = keyboardType;
    _obscureText = obscureText;
    _hintText = hintText;
    if (mask != null && mask != "")
      _mask.add(new MaskTextInputFormatter(mask: mask));
    _validator = validator;
    _onChanged = onChanged;
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
      focusNode: _focusNode,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 25, 15, 15),
          hintStyle: TextStyle(
              color: AppColors.formHint, fontSize: 20.0, fontFamily: 'Nunito'),
          hintText: _hintText,
          filled: true,
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
