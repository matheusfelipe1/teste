import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final Function(bool) _onChanged;
  final bool _value;
  final String _text;

  CustomCheckbox({Key key, Function(bool) onChanged, bool value, String text})
      : _onChanged = onChanged,
        _value = value,
        _text = text,
        super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  Function(bool) get _onChanged => widget._onChanged;
  bool get _value => widget._value;
  String get _text => widget._text;
  bool value = false;
  @override
  void initState() {
    super.initState();
    value = _value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[_bindButton(), _bindText()],
      ),
      onTap: () {
        setState(() {
          value = !value;
        });
        _onChanged(value);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bindButton() {
    if (value)
      return Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            gradient: AppColors.checkGradient,
            border: Border.all(
                color: AppColors.mainBorder,
                width: 2.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        child: Center(
          child: Image.asset(
            'assets/images/checked.png',
            height: 8,
          ),
        ),
      );
    else
      return Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: AppColors.support3,
            border: Border.all(
                color: AppColors.mainBorder,
                width: 2.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
      );
  }

  Widget _bindText() {
    return Flexible(
      child: Container(
          child: Text(
        _text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: value ? AppColors.firstFont : AppColors.mainFont,
            fontFamily: "Nunito",
            fontSize: 14.0),
      )),
    );
  }
}
