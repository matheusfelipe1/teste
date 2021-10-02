import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/modules/home/waiting_confirm_email/waiting_confirm_email_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class WaitingConfirmEmailPage extends StatefulWidget {
  @override
  _WaitingConfirmEmailPageState createState() =>
      _WaitingConfirmEmailPageState();
}

class _WaitingConfirmEmailPageState extends State<WaitingConfirmEmailPage> {
  WaitingConfirmEmailController _controller;

  @override
  void initState() {
    _controller = Modular.get<WaitingConfirmEmailController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(gradient: AppColors.colorBackgroundGradient),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/im_aguardando_email.png',
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Estamos aguardando \n sua confirmação de email',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.white,
                                  decorationStyle: null,
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              Text(
                                'Verifique sua caixa de entrada \n e caixa de spam',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 13,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Precisa que o email seja reenviado?',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.sendToConfirmEmail(context);
                              },
                              child: Observer(
                                builder: (_) {
                                  return Text(
                                    _controller.isLoading
                                        ? "Enviando..."
                                        : 'Clique aqui',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: _controller.isLoading
                                          ? Colors.black87
                                          : AppColors.purple,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Nunito',
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                              child: Divider(
                                height: 1.0,
                                color: AppColors.support1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 0.0,
                                      left: 24.0,
                                      right: 12.0),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: CustomOutlineButton(
                                    text: "SAIR",
                                    onPressed: () {
                                      Modular.get<AuthController>().signOut();
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 0.0,
                                      left: 12.0,
                                      right: 24.0),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Observer(
                                    builder: (_) {
                                      return PrimaryButton(
                                        text: _controller.isVerifyLoading
                                            ? "VERIFICANDO..."
                                            : "JÁ VERIFIQUEI",
                                        onPressed: _controller.isVerifyLoading
                                            ? null
                                            : () {
                                                _controller
                                                    .verifyEmail(context);
                                              },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
}
