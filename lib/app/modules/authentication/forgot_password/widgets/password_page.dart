import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  ForgotPasswordController _controller;
  TextEditingController _passwordController;
  AuthController _authController;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ForgotPasswordController>();
    _authController = Modular.get<AuthController>();
    _passwordController = new TextEditingController();
    _passwordController.text = _controller.forgotPassword.password != null
        ? _controller.forgotPassword.password
        : '';
    _controller.showPassword = false;
    if (_passwordController.text != '') {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
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
                          padding: EdgeInsets.all(20.0),
                          child: Observer(builder: (_) {
                            return SignUpTextField(
                              autocorrect: false,
                              autovalidate: true,
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
                              controller: _passwordController,
                              hintText: "Minha senha é",
                              keyboardType: TextInputType.text,
                              obscureText: !_controller.showPassword,
                              validator: (text) {
                                final result =
                                    _controller.validatePassword(text);
                                _controller.isButtonDisabled =
                                    result == null ? false : true;
                                return result;
                              },
                              onChanged: (text) {
                                final result =
                                    _controller.validatePassword(text);
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
                                text: "PRÓXIMO",
                                onPressed: _controller.isButtonDisabled
                                    ? null
                                    : () {
                                        setState(() {
                                          _controller.isButtonDisabled = true;
                                        });
                                        _controller.forgotPassword.email =
                                            _passwordController.text;
                                        Modular.to.pushNamed('/home');
                                      });
                          }))
                    ],
                  ))),
        );
      },
    );
  }
}
