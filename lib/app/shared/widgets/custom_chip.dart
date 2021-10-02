import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class CustomChip extends StatefulWidget {
  final Function(bool) _onChanged;
  final bool _value;
  final String _text;

  CustomChip({Key key, Function(bool) onChanged, bool value, String text})
      : _onChanged = onChanged,
        _value = value,
        _text = text,
        super(key: key);

  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
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
      child: _bindButton(),
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
    return Container(
        height: 46.09,
        padding:
            EdgeInsets.only(left: 14.0, right: 5.0, top: 14.0, bottom: 14.0),
        margin: EdgeInsets.only(top: 6.45, right: 15),
        decoration: BoxDecoration(
            color: value ? AppColors.support1 : null,
            border: Border.all(
                color: value ? AppColors.selectedBorder : AppColors.mainBorder,
                width: 1.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        child: Container(
            child: Align(
          child: Text(
            _text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: value ? AppColors.firstFont : AppColors.mainFont,
                fontFamily: "Nunito",
                fontSize: 12.0),
          ),
          alignment: Alignment.centerLeft,
        )));
  }
}
