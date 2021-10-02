import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/enums/forgot_password_status.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  ForgotPasswordController _controller;
  AuthController _authController;
  TextEditingController _emailController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ForgotPasswordController>();
    _authController = Modular.get<AuthController>();
    _emailController = new TextEditingController();
    if (_controller.forgotPassword.email == null)
      _controller.forgotPassword.email = '';
    _emailController.text = _controller.forgotPassword.email;
    _controller.forgotPasswordStatus = ForgotPasswordStatus.waiting;

    final result = _controller.validateEmail(_emailController.text);
    setState(() {
      _controller.isButtonDisabled = result == null ? false : true;
    });

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
              child: DecoratedBox(
                  position: DecorationPosition.background,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_galaxy.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(20.0),
                          child: Observer(builder: (_) {
                            return SignUpTextField(
                              autocorrect: false,
                              focusNode: focusNode,
                              autovalidate: true,
                              controller: _emailController,
                              hintText: "Meu e-mail é",
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: (text) {
                                if (isTouched && isValidationEnabled) {
                                  final result =
                                      _controller.validateEmail(text);
                                  _controller.isButtonDisabled =
                                      result == null ? false : true;
                                  return result;
                                } else
                                  return null;
                              },
                              onChanged: (text) {
                                setState(() {
                                  isTouched = true;
                                });
                                final result = _controller.validateEmail(text);
                                _controller.isButtonDisabled =
                                    result == null ? false : true;
                              },
                            );
                          })),
                      Container(
                          width: 155,
                          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Observer(builder: (_) {
                            return PrimaryButton(
                                text: _controller.isLoading
                                    ? "CARREGANDO..."
                                    : "ENVIAR",
                                onPressed: _controller.isButtonDisabled ||
                                        _controller.isLoading
                                    ? null
                                    : () async {
                                        _controller.forgotPassword.email =
                                            _emailController.text;
                                        await _controller
                                            .sendPasswordResetEmail(
                                                _emailController.text
                                                    .toString(),
                                                context);
                                      });
                          }))
                    ],
                  ))),
        );
      },
    );
  }
}
