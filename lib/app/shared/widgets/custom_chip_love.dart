import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class CustomChipLove extends StatefulWidget {
  final Function(bool) _onChanged;
  final bool _value;
  final String _textTitle;
  final String _textBody;
  final String _icon;
  final String _iconLight;

  CustomChipLove(
      {Key key,
      Function(bool) onChanged,
      bool value,
      String textTitle,
      String textBody,
      String icon,
      String iconLight})
      : _onChanged = onChanged,
        _value = value,
        _textTitle = textTitle,
        _textBody = textBody,
        _icon = icon,
        _iconLight = iconLight,
        super(key: key);

  @override
  _CustomChipLoveState createState() => _CustomChipLoveState();
}

class _CustomChipLoveState extends State<CustomChipLove> {
  Function(bool) get _onChanged => widget._onChanged;
  bool get _value => widget._value;
  String get _textTitle => widget._textTitle;
  String get _textBody => widget._textBody;
  String get _icon => widget._icon;
  String get _iconLight => widget._iconLight;
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
    print(value);
    return Container(
        margin: EdgeInsets.only(top: 6.45, right: 20),
        padding: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
            color: value ? AppColors.support1 : AppColors.white,
            border: Border.all(
                color: AppColors.selectedBorder,
                width: 1.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 15.0, left: 15.0, right: 15.0),
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(
                    color: value ? AppColors.support1 : AppColors.white,
                    border: Border(
                        bottom: BorderSide(color: AppColors.selectedBorder))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _textTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color:
                              value ? AppColors.firstFont : AppColors.mainFont,
                          fontFamily: "Nunito",
                          fontSize: 12.0),
                    ),
                    Image.asset(
                      value ? _icon : _iconLight,
                      width: 30.0,
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                _textBody,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: value ? AppColors.firstFont : AppColors.mainFont,
                    fontFamily: "Nunito",
                    fontSize: 12.0),
              ),
            )
          ],
        ));
  }
}
