import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/login/login_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/facebook_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _controller;
  SignUpController _signController;
  AuthController _authController;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<LoginController>();
    _signController = Modular.get<SignUpController>();
    _authController = Modular.get<AuthController>();
    getLocation();
  }

  getLocation() async {
    await _authController.geoLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/painel_login.png',
                ),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).viewPadding.top,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Venha conhecer quem\ntem afinidade com você.',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.white,
                              fontFamily: 'Nunito')),
                    ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0 + MediaQuery.of(context).padding.bottom,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/im_touro.png',
                    width: MediaQuery.of(context).size.width * 0.5439,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 5.0),
                  //   width: 250,
                  //   child: PrimaryButton(
                  //     onPressed: () {
                  //       Modular.to.pushNamed('/auth/phone-auth');
                  //     },
                  //     text: "ENTRAR COM NÚMERO DE TELEFONE",
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    width: 220,
                    height: 37,
                    child: PrimaryButton(
                      onPressed: () async {
                        Modular.to.pushNamed('/auth/sign-up');
                      },
                      text: "CRIAR UMA NOVA CONTA",
                    ),
                  ),

                  Observer(
                    builder: (_) {
                      return Container(
                        width: 220,
                        height: 37,
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.all(0),
                        child: FaceboookButton(
                          onPressed: () {
                            if (!_controller.isLoading)
                              _controller.doFacebookLogin(context);
                          },
                          text: _controller.isLoading
                              ? "CARREGANDO..."
                              : "ENTRAR COM FACEBOOK",
                        ),
                      );
                    },
                  ),
                  Container(
                      width: 220,
                      height: 37,
                      margin: EdgeInsets.only(top: 3.0),
                      child: FlatButton(
                        onPressed: () {
                          Modular.to.pushNamed('/auth/entrar');
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'ENTRAR',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.purple,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Ao continuar, você concorda com nossos\n',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.secondFont,
                              fontFamily: 'Nunito'),
                        ),
                        TextSpan(
                            text: 'Termos de Serviço',
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Modular.to.pushNamed('/profile/config/service');
                            },
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.fontLink,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito')),
                        TextSpan(
                            text: ' e ',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.secondFont,
                                fontFamily: 'Nunito')),
                        TextSpan(
                            text: 'Politica de Privacidade',
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Modular.to.pushNamed('/profile/config/politics');
                            },
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.fontLink,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito')),
                      ]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )),
      ],
    ));
  }
}
