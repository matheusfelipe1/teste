import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_box_field.dart';

import 'always_visible_scrollbar.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class OptionsDialog extends StatefulWidget {
  final String _titleCustom;
  final String _titleBold;
  final String _titlePurple;
  final bool _ice;
  final String _buttonText;
  final bool _hasButton;
  final String _image;

  OptionsDialog(
      {Key key,
      @required String titleCustom,
      String titleBold,
      @required String titlePurple,
      @required bool hasButton,
      @required bool ice,
      @required String image,
      String buttonText})
      : _titlePurple = titlePurple,
        _titleBold = titleBold,
        _titleCustom = titleCustom,
        _image = image,
        _ice = ice,
        _buttonText = buttonText,
        _hasButton = hasButton,
        super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  List options = [
    {
      'text': 'Sem motivos',
      'icon_light': 'assets/images/ic_sem_motivos_cinza.png',
      'icon': 'assets/images/ic_sem_motivos_roxo.png',
      'marked': false
    },
    {
      'text': 'Msgs inapropriadas',
      'icon_light': 'assets/images/ic_inapropriada_cinza.png',
      'icon': 'assets/images/ic_inapropriada_roxo.png',
      'marked': false
    },
    {
      'text': 'Fotos inadequadas',
      'icon_light': 'assets/images/ic_foto_inadequada_cinza.png',
      'icon': 'assets/images/ic_foto_inadequada_roxo.png',
      'marked': false
    },
    {
      'text': 'Má atitude offline',
      'icon_light': 'assets/images/ic_subtracao_cinza.png',
      'icon': 'assets/images/ic_subtracao_roxo.png',
      'marked': false
    },
    {
      'text': 'Parece spam',
      'icon_light': 'assets/images/ic_spam_cinza.png',
      'icon': 'assets/images/ic_spam_roxo.png',
      'marked': false
    },
    {
      'text': 'Outro',
      'icon_light': 'assets/images/ic_outro_cinza.png',
      'icon': 'assets/images/ic_outro_roxo.png',
      'marked': false
    },
  ];

  bool showInputOther = false;

  TextEditingController _otherHourController;

  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollController2 = new ScrollController();

  @override
  void initState() {
    super.initState();
    _otherHourController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Material(
              color: AppColors.backgroundDialog,
              elevation: 0,
              child: Center(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      child: _dialogContent(context))),
            )));
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.only(
              top: 9.0,
              bottom: 12.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white30,
                  blurRadius: 20.0,
                  offset: const Offset(0.0, 25.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  widget._image,
                  height: 54,
                ),
                widget._ice == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 9.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: widget._titleCustom + ' \n',
                                style: TextStyle(
                                    color: AppColors.mainFontOpacity9,
                                    fontSize: 11.0,
                                    fontFamily: 'Nunito')),
                            TextSpan(
                                text: widget._titleBold + '\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainFontOpacity9,
                                    fontSize: 11.0,
                                    fontFamily: 'Nunito')),
                            TextSpan(
                                text: widget._titlePurple,
                                style: TextStyle(
                                    height: 1.5,
                                    color: AppColors.firstFont,
                                    fontSize: 16.0,
                                    fontFamily: 'Nunito'))
                          ]),
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: widget._titlePurple + ' \n',
                              style: TextStyle(
                                  height: 2.3,
                                  color: AppColors.firstFont,
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito')),
                          TextSpan(
                              text: widget._titleBold,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainFontOpacity9,
                                  fontSize: 12.0,
                                  fontFamily: 'Nunito')),
                        ]),
                      ),
                Container(
                    margin: EdgeInsets.only(top: 19.0),
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 27.0, right: 27.0),
                    color: AppColors.dialogBox,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(11, 11, 11, 0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child:
                                // ListView.builder(
                                //   controller: _scrollController2,
                                //   itemCount: options.length,
                                //   itemBuilder: (BuildContext context, int index) {

                                AlwaysVisibleScrollbar.grid(
                              crossAxisCount: 1,
                              controller: _scrollController2,
                              padding: EdgeInsets.only(right: 10),
                              scrollDirection: Axis.vertical,
                              childAspectRatio: 4.5,
                              scrollbarColor: AppColors.formBorder,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              children: map<Widget>(
                                options,
                                (index, url) {
                                  return GestureDetector(
                                    child: _bindButton(index),
                                    onTap: () {
                                      unmarkAll(index);
                                      if (options[index]['text'] == 'Outro') {
                                        scrollDown();
                                      }
                                    },
                                  );
                                },
                              ),
                            )),
                        showInputOther == true ? _bindInput() : Container()
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _getButton(context),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 12.47,
          child: GestureDetector(
            child: Image.asset(
              'assets/images/close.png',
              height: 20.0,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  unmarkAll(int index) {
    for (var i = 0; i < options.length; i++) {
      setState(() {
        options[i]['marked'] = false;
      });
    }
    setState(() {
      options[index]['marked'] = !options[index]['marked'];
    });
  }

  Widget _getButton(BuildContext context) {
    if (widget._hasButton)
      return Container(
          margin: EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 120,
                  padding: EdgeInsets.only(right: 13),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColors.dialogBox,
                          borderRadius: BorderRadius.circular(8)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              buttonTheme: ButtonTheme.of(context).copyWith(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap)),
                          child: OutlineButton(
                            focusColor: AppColors.dialogBox,
                            hoverColor: AppColors.dialogBox,
                            borderSide: BorderSide(
                              color: AppColors.mainBorder,
                              width: 2.0,
                            ),
                            highlightedBorderColor: AppColors.mainBorder,
                            highlightColor: AppColors.dialogBox,
                            color: AppColors.dialogBox,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'CANCELAR',
                              style: TextStyle(
                                  color: AppColors.fontOptionsDialog,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.0),
                            ),
                          )))),
              Container(
                  width: 120,
                  child: PrimaryButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: () async {
                      var option = options.firstWhere((opt) => opt['marked'])['text'];
                      if(option == "Outro") {
                        if(_otherHourController.text.length > 0) {
                          Navigator.of(context).pop("$option: ${_otherHourController.text}");
                        }
                      } else
                        Navigator.of(context).pop(option);
                    },
                    text: widget._buttonText,
                  ))
            ],
          ));
    else
      return Container();
  }

  Widget _bindButton(int index) {
    return Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color:
                options[index]['marked'] ? AppColors.support1 : AppColors.white,
            border: Border(
              top: BorderSide(
                  color: options[index]['marked']
                      ? AppColors.selectedBorder
                      : AppColors.formBorder,
                  width: 0.7,
                  style: BorderStyle.solid),
              bottom: BorderSide(
                  color: options[index]['marked']
                      ? options[index]['text'] == 'Outro'
                          ? AppColors.support1
                          : AppColors.selectedBorder
                      : AppColors.formBorder,
                  width: options[index]['text'] == 'Outro' ? 0 : 0.7,
                  style: BorderStyle.solid),
              left: BorderSide(
                  color: options[index]['marked']
                      ? AppColors.selectedBorder
                      : AppColors.formBorder,
                  width: 1.0,
                  style: BorderStyle.solid),
              right: BorderSide(
                  color: options[index]['marked']
                      ? AppColors.selectedBorder
                      : AppColors.formBorder,
                  width: 1.0,
                  style: BorderStyle.solid),
            )),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: options[index]['marked']
                      ? AppColors.support1
                      : AppColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        options[index]['text'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: options[index]['marked']
                                ? AppColors.firstFont
                                : AppColors.fontOptionsDialog,
                            fontFamily: "Nunito",
                            fontSize: 14.0),
                      ),
                    ),
                    Container(
                        height: 20,
                        child: Image.asset(
                          options[index]['marked']
                              ? options[index]['icon']
                              : options[index]['icon_light'],
                          width: 20.0,
                        ))
                  ],
                )),
            options[index]['marked'] && options[index]['text'] == 'Outro'
                ? _showInputOther(true)
                : _showInputOther(false)
          ],
        ));
  }

  _showInputOther(bool value) {
    setState(() {
      // value ? _otherHourController. : _otherHourController;
      showInputOther = value;
    });
    return Container();
  }

  _bindInput() {
    scrollDown();
    return Material(
        color: AppColors.dialogBox,
        child: Container(
          margin: EdgeInsets.only(left: 11, right: 26, bottom: 8),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
          decoration: BoxDecoration(
              color: AppColors.support1,
              border: Border(
                bottom: BorderSide(
                    color: AppColors.selectedBorder,
                    width: 0.7,
                    style: BorderStyle.solid),
                left: BorderSide(
                    color: AppColors.selectedBorder,
                    width: 1.0,
                    style: BorderStyle.solid),
                right: BorderSide(
                    color: AppColors.selectedBorder,
                    width: 1.0,
                    style: BorderStyle.solid),
              )),
          child: SignUpBoxField(
            autocorrect: false,
            autovalidate: true,
            autofocus: true,
            enable: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            colorFont: AppColors.mainFont,
            background: AppColors.formBackground,
            maxLines: 4,
            controller: _otherHourController,
            hintText: "Descreva o motivo para nós...",
            keyboardType: TextInputType.text,
            obscureText: false,
            validator: (_) {},
          ),
        ));
  }

  scrollDown() {
    return Timer(Duration(milliseconds: 150), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _scrollController2.jumpTo(_scrollController2.position.maxScrollExtent);
    });
  }
}
