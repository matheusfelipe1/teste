import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  ForgotPasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ForgotPasswordController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: AppColors.colorBackgroundGradient),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/jih1.png',
                    height: 130,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Xiiii, algo deu errado. Desculpe!',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Text(
                          'Por favor, tente novamente.',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 13,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: 140,
                    child: PrimaryButton(
                      text: "TENTE NOVAMENTE",
                      onPressed: () {
                        _controller.tryAgain();
                      },
                    ),
                  ),
                ))
          ],
        ));
  }
}
