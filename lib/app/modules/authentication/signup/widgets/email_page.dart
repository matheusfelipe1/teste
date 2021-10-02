import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  SignUpController _controller;
  AuthController _authController;
  TextEditingController _emailController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _authController = Modular.get<AuthController>();
    _emailController = new TextEditingController();
    _emailController.text = _authController.currentUser != null
        ? _authController.currentUser.email
        : _controller.profile.email != null
            ? _controller.profile.email
            : _authController.facebookProfile != null
                ? _authController.facebookProfile.email
                : '';
    if (_emailController.text != '') {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                JihTip(
                  imagePath: "assets/images/jih1.png",
                  text: "Para ativar sua conta precisamos saber seu email",
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Observer(builder: (_) {
                        return SignUpTextField(
                          autocorrect: false,
                          autovalidate: true,
                          disabled: false,
                          focusNode: focusNode,
                          controller: _emailController,
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
                            if (text.contains(" ")) {
                              text = text.replaceAll(new RegExp(r"\s+"), "");
                              _emailController..text = text;
                              _emailController
                                ..selection = TextSelection.collapsed(
                                    offset: text.length);
                            }
                            setState(() {
                              isTouched = true;
                            });
                            _controller.validateEmail(text);
                          },
                        );
                      }),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Enviaremos um email que precisará ser \n confirmado por você.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: AppColors.thirthFont,
                              fontSize: 12,
                              fontFamily: 'Nunito'),
                        ))
                  ],
                ),
                Column(
                  children: <Widget>[
                    Divider(
                      height: 2,
                      color: AppColors.dividerBorder,
                      thickness: 1,
                    ),
                    Container(
                      width: 155,
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Observer(builder: (_) {
                        return PrimaryButton(
                            text:
                                _controller.sending ? 'SALVANDO...' : "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled ||
                                    _controller.loading ||
                                    _controller.sending
                                ? null
                                : () {
                                    setState(() {
                                      _controller.isButtonDisabled = true;
                                    });
                                    _controller.profile.email =
                                        _emailController.text.toString();
                                    _controller.saveUser(context);
                                  });
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
