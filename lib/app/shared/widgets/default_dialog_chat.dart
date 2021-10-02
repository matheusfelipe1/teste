import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

class DefaultDialogChat extends StatelessWidget {
  final String _textBold;
  final String _textPurple;
  final bool _textFooter;
  final String _description;
  final String _image;
  final String _buttonText;
  final bool _hasButton;
  final bool _ice;

  DefaultDialogChat(
      {Key key,
      @required String textBold,
      @required String textPurple,
      @required String image,
      @required String description,
      @required bool textFooter,
      @required bool hasButton,
      @required bool ice,
      String buttonText})
      : _textBold = textBold,
        _textPurple = textPurple,
        _textFooter = textFooter,
        _image = image,
        _ice = ice,
        _description = description,
        _buttonText = buttonText,
        _hasButton = hasButton,
        super(key: key);

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
                      padding: EdgeInsets.fromLTRB(23, 0, 23, 15),
                      child: _dialogContent(context)),
                ))));
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 25.0,
            bottom: 21.0,
          ),
          margin: EdgeInsets.only(top: 9.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                _image,
                height: 54,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 9.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _textBold,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                            color: AppColors.mainFontOpacity9),
                      ),
                      _ice
                          ? Text(
                              _textPurple,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  color: AppColors.firstFont),
                            )
                          : Container()
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                padding: EdgeInsets.only(
                    top: 22.0, bottom: 22.0, left: 25.0, right: 25.0),
                color: AppColors.dialogBox,
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(11.0),
                    child: Text(
                      _description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14.0,
                          color: AppColors.thirthFont),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 8.0, left: 35.0, right: 35.0),
                  color: AppColors.white,
                  child: Container(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: _textFooter
                          ? _ice
                              ? TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'Caso deseje voltar a conversar\n é só acessar sua ',
                                      style: TextStyle(
                                          color: AppColors.secondFont,
                                          fontSize: 12.0,
                                          fontFamily: 'Nunito')),
                                  TextSpan(
                                      text: 'geladeira',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //Modular.to.pop();
                                          Modular.to.canPop();
                                          Modular.to.pushNamed('chat/fridge');
                                        },
                                      style: TextStyle(
                                          color: AppColors.fontLink,
                                          fontSize: 12.0,
                                          fontFamily: 'Nunito')),
                                ])
                              : TextSpan(
                                  text:
                                      'Iremos analisar o caso e tomar\n a melhor decisão para que \no joinder.me seja um lugar\n seguro e do bem.',
                                  style: TextStyle(
                                      color: AppColors.secondFont,
                                      fontSize: 12.0,
                                      fontFamily: 'Nunito'))
                          : TextSpan(),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: _getButton(context),
              ),
            ],
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

  Widget _getButton(BuildContext context) {
    if (_hasButton)
      return Container(
        width: 145,
        child: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: _buttonText,
        ),
      );
    else
      return Container();
  }
}
