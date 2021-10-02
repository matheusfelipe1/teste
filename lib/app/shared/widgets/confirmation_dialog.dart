import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_box_field.dart';

class ConfirmationDialog extends StatefulWidget {
  final String _titleBold;
  final String _titleGray;
  final String _titleDesc;
  final String _negativeText;
  final String _confirmationText;
  final bool _hasButton;
  final String _image;

  ConfirmationDialog({
    Key key,
    @required String titleBold,
    @required String titleGray,
    @required String titleDesc,
    @required String negativeText,
    @required String confirmationText,
    @required bool hasButton,
    @required String image,
  })  : _titleBold = titleBold,
        _titleGray = titleGray,
        _titleDesc = titleDesc,
        _image = image,
        _confirmationText = confirmationText,
        _negativeText = negativeText,
        _hasButton = hasButton,
        super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
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
                          EdgeInsets.symmetric(vertical: 10, horizontal: 23),
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
                Padding(
                  padding: EdgeInsets.only(top: 9.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: widget._titleBold + '\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainFontOpacity9,
                              fontSize: 11.0,
                              fontFamily: 'Nunito')),
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: widget._titleGray,
                          style: TextStyle(
                              height: 1.5,
                              color: AppColors.thirthFont,
                              fontSize: 14.0,
                              fontFamily: 'Nunito'))
                    ]),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 19.0),
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.dialogBox,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            widget._titleDesc,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.thirthFont,
                                fontFamily: 'Nunito'),
                          ),
                        ),
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
              Navigator.of(context).pop(false);
            },
          ),
        ),
      ],
    );
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
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              widget._negativeText,
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
                      Navigator.of(context).pop(true);
                    },
                    text: widget._confirmationText,
                  ))
            ],
          ));
    else
      return Container();
  }
}
