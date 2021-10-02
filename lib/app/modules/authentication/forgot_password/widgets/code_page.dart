import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/enums/forgot_password_status.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../forgot_password_controller.dart';

class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  ForgotPasswordController _controller;
  TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ForgotPasswordController>();
    _codeController = new TextEditingController();
    if (_codeController.text != '') {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: DecoratedBox(
                  position: DecorationPosition.background,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_galaxy.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(40, 27, 40, 15),
                        child: Text(
                            "Nós enviamos um e-mail de recuperação para ${_controller.forgotPassword.email}",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Nunito')),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: Text(
                            "Se você não encontrou o e-mail, por favor verifique o spam.",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.white,
                                fontSize: 14,
                                fontFamily: 'Nunito')),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 0.0),
                          child: Observer(builder: (_) {
                            return PinCodeTextField(
                              length: 6,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 37,
                                fieldWidth: 37,
                                activeColor: AppColors.white,
                                activeFillColor: AppColors.white,
                                disabledColor: AppColors.white,
                                inactiveColor: AppColors.white,
                                inactiveFillColor: AppColors.white,
                                selectedColor: AppColors.purple,
                                selectedFillColor: Colors.white,
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              textStyle: TextStyle(
                                  color: AppColors.firstFont,
                                  fontSize: 20.0,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700),
                              textInputType: TextInputType.number,
                              onCompleted: (v) {
                                _controller.forgotPasswordStatus =
                                    ForgotPasswordStatus.success;
                                // _controller.submitCode(v);
                              },
                              onChanged: (text) {
                                if (text.length < 6) {
                                  // setState(() {
                                  _controller.forgotPasswordStatus =
                                      ForgotPasswordStatus.waiting;
                                  // });
                                }
                              },
                            );
                          })),
                      Observer(builder: (_) {
                        print('3  =>> ${_controller.isButtonDisabled}');
                        if (_controller.forgotPasswordStatus ==
                            ForgotPasswordStatus.checking) {
                          return Container(
                            color: AppColors.backgroundYellowMsg,
                            padding: EdgeInsets.fromLTRB(10, 7, 0, 10),
                            margin: EdgeInsets.fromLTRB(
                                35,
                                10,
                                MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width * 0.65,
                                15),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Verificando seu código...",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nunito')),
                          );
                        } else if (_controller.forgotPasswordStatus ==
                            ForgotPasswordStatus.wrongCode) {
                          return Container(
                            color: AppColors.backgroundRedMsg,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(10, 7, 0, 10),
                            margin: EdgeInsets.fromLTRB(30, 10, 25, 15),
                            child: Text(
                                "Código errado. Por favor, tente de novo",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    color: AppColors.white,
                                    fontFamily: 'Nunito')),
                          );
                        } else if (_controller.forgotPasswordStatus ==
                            ForgotPasswordStatus.success) {
                          _controller.forgotPasswordStatus =
                              ForgotPasswordStatus.waiting;
                          _controller.setPage(2);
                        }
                        return Container();
                      })
                    ],
                  ))),
        );
      },
    );
  }
}
