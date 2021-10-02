import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import '../profile_controller.dart';

class ConfigEmailPage extends StatefulWidget {
  @override
  _ConfigEmailPageState createState() => _ConfigEmailPageState();
}

class _ConfigEmailPageState extends State<ConfigEmailPage> {
  ProfileController _controller;
  AuthController _authController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _authController = Modular.get<AuthController>();

    _controller.emailController.text = _authController.currentUser != null
        ? _authController.currentUser.email
        : _controller.profile.email != null
            ? _controller.profile.email
            : _authController.facebookProfile != null
                ? _authController.facebookProfile.email
                : '';

    focusNode = new FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus)
        setState(() {
          isValidationEnabled = true;
        });
      else
        setState(() {
          isValidationEnabled = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Configurações",
              style: TextStyle(
                  color: AppColors.white, fontFamily: 'Nunito', fontSize: 20.0),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: AppColors.configGradient),
            ),
            actions: <Widget>[
              Observer(
                builder: (_) {
                  return FlatButton(
                    child: Text(
                      "SALVAR",
                      style: TextStyle(
                          color: (_controller.emailController.text == "" ||
                                  _controller.emailController.text.length ==
                                      0 ||
                                  _controller.validateEmail(
                                          _controller.emailController.text) !=
                                      null)
                              ? Colors.grey
                              : AppColors.white,
                          fontSize: 12.0,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () async {
                      if (_controller.emailController.text != "" &&
                          _controller.emailController.text.length > 0 &&
                          _controller.validateEmail(
                                  _controller.emailController.text) ==
                              null) _controller.changeEmail(context);
                    },
                  );
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 29.0, bottom: 21.0, right: 22, left: 22.0),
                  child: Text(
                    "MINHA CONTA",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColors.mainFont,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  color: AppColors.formBorder,
                  height: 1.0,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 16.0, right: 22, left: 22.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/email.png',
                        height: 24.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 22),
                        child: Text(
                          "E-MAIL",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.mainFont,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Observer(
                    builder: (_) {
                      if (!_controller.isLoading) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 22.0),
                          child: SignUpTextField(
                            autocorrect: false,
                            autovalidate: true,
                            disabled: false,
                            focusNode: focusNode,
                            controller: _controller.emailController,
                            hintText: "Meu e-mail é",
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            validator: (text) {
                              if (isTouched && isValidationEnabled) {
                                final result = _controller.validateEmail(text);
                                return result;
                              } else
                                return null;
                            },
                            onChanged: (text) {
                              setState(() {
                                isTouched = true;
                              });
                            },
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.purple)),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
