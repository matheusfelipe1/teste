import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class CustomCheckboxSimple extends StatefulWidget {
  final Function(bool) _onChanged;
  final bool _value;

  CustomCheckboxSimple({Key key, Function(bool) onChanged, bool value})
      : _onChanged = onChanged,
        _value = value,
        super(key: key);

  @override
  _CustomCheckboxSimpleState createState() => _CustomCheckboxSimpleState();
}

class _CustomCheckboxSimpleState extends State<CustomCheckboxSimple> {
  Function(bool) get _onChanged => widget._onChanged;
  bool get _value => widget._value;
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
        children: <Widget>[
          _bindButton(),
        ],
      ),
      onTap: () {
        print('object');
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
        width: 23,
        height: 23,
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
        width: 23,
        height: 23,
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
}
