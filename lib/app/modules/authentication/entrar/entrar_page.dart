import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/entrar/entrar_controller.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:joinder_app/app/modules/authentication/login/login_controller.dart';
import 'package:joinder_app/app/shared/enums/forgot_password_status.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/facebook_button.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

class EntrarPage extends StatefulWidget {
  @override
  _EntrarPageState createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  EntrarController _controller;
  LoginController _loginController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode emailFocusNode;
  FocusNode passwordFocusNode;
  bool isEmailTouched = false;
  bool isEmailValidationEnabled = false;
  bool isPasswordTouched = false;
  bool isPasswordValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<EntrarController>();
    _loginController = Modular.get<LoginController>();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _controller.isLoading = false;
    _controller.showPassword = false;

    emailFocusNode = new FocusNode();
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus)
        setState(() {
          isEmailValidationEnabled = true;
        });
      else
        setState(() {
          isEmailValidationEnabled = false;
        });
    });

    passwordFocusNode = new FocusNode();
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus)
        setState(() {
          isPasswordValidationEnabled = true;
        });
      else
        setState(() {
          isPasswordValidationEnabled = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Entrar',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            ),
          ),
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: DecoratedBox(
                        position: DecorationPosition.background,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg_galaxy.jpg'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  child: Observer(builder: (_) {
                                    return SignUpTextField(
                                      autocorrect: false,
                                      autovalidate: true,
                                      controller: _emailController,
                                      focusNode: emailFocusNode,
                                      hintText: "Meu e-mail é",
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: false,
                                      validator: (text) {
                                        if (isEmailTouched &&
                                            isEmailValidationEnabled) {
                                          final result =
                                              _controller.validateEmail(text);
                                          _controller.isButtonDisabled =
                                              !_controller.validateForm(
                                                  _passwordController.text,
                                                  text);
                                          return result;
                                        } else
                                          return null;
                                      },
                                      onChanged: (text) {
                                        setState(() {
                                          isEmailTouched = true;
                                        });
                                        final result =
                                            _controller.validateEmail(text);
                                        _controller.isButtonDisabled =
                                            result == null ? false : true;
                                      },
                                    );
                                  }),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                                  child: Observer(builder: (_) {
                                    return SignUpTextField(
                                      autocorrect: false,
                                      autovalidate: true,
                                      controller: _passwordController,
                                      focusNode: passwordFocusNode,
                                      hintText: "Minha senha é",
                                      suffixIcon: IconButton(
                                        icon: Image.asset(
                                          _controller.showPassword
                                              ? 'assets/images/eye_hidden.png'
                                              : 'assets/images/eye_show.png',
                                          width: 24,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controller.showPassword =
                                                !_controller.showPassword;
                                          });
                                        },
                                      ),
                                      keyboardType: TextInputType.text,
                                      obscureText: !_controller.showPassword,
                                      validator: (text) {
                                        if (isPasswordTouched &&
                                            isPasswordValidationEnabled) {
                                          final result = _controller
                                              .validatePassword(text);
                                          _controller.isButtonDisabled =
                                              !_controller.validateForm(
                                                  text, _emailController.text);
                                          return result;
                                        } else
                                          return null;
                                      },
                                      onChanged: (text) {
                                        setState(() {
                                          isPasswordTouched = true;
                                        });
                                        final result =
                                            _controller.validatePassword(text);
                                        _controller.isButtonDisabled =
                                            result == null ? false : true;
                                      },
                                    );
                                  }),
                                ),
                                Container(
                                    width: 155,
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Observer(builder: (_) {
                                      return PrimaryButton(
                                          text: _controller.isLoading
                                              ? 'CARREGANDO...'
                                              : "ENTRAR",
                                          onPressed: _controller
                                                      .isButtonDisabled ||
                                                  _controller.isLoading ||
                                                  !isPasswordTouched ||
                                                  !isEmailTouched
                                              ? () async {
                                                  Modular.to
                                                      .pushNamed('/home/');
                                                }
                                              : () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  _controller.isButtonDisabled =
                                                      true;
                                                  await _controller
                                                      .doEmailPasswordLogin(
                                                          _emailController.text,
                                                          _passwordController
                                                              .text,
                                                          context);
                                                  _controller.isButtonDisabled =
                                                      false;
                                                });
                                    })),
                                Container(
                                  child: FlatButton(
                                    onPressed: () {
                                      Modular.to
                                          .pushNamed('/auth/forgot-password');
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      'ESQUECEU SUA SENHA?',
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
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 210,
                              padding: EdgeInsets.only(top: 12.0, bottom: 30.0),
                              child: Observer(
                                builder: (_) {
                                  return Container(
                                    width: 220,
                                    height: 37,
                                    margin: EdgeInsets.only(top: 5.0),
                                    padding: EdgeInsets.all(0),
                                    child: FaceboookButton(
                                      onPressed: () {
                                        if (!_loginController.isLoading)
                                          _loginController
                                              .doFacebookLogin(context);
                                      },
                                      text: _loginController.isLoading
                                          ? "CARREGANDO..."
                                          : "ENTRAR COM FACEBOOK",
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ))));
          })),
    );
  }
}
