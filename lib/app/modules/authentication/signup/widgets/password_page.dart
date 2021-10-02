import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/validators/validators.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  SignUpController _controller;
  TextEditingController _passwordController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _passwordController = new TextEditingController();
    _passwordController.text = _controller.profile.password != null
        ? _controller.profile.password
        : '';
    _controller.showPassword = false;
    Future.delayed(
        Duration(milliseconds: 100),
        () => {
              if (_controller.validatePassword(_passwordController.text) !=
                  null)
                setState(() {
                  _controller.isButtonDisabled = true;
                })
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                JihTip(
                  imagePath: "assets/images/jih1.png",
                  text: "Escreva sua senha. \nCuidado!! Não vai esquecer heim!",
                ),
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Observer(builder: (_) {
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
                            focusNode: focusNode,
                            obscureText: !_controller.showPassword,
                            validator: (text) {
                              if (isTouched && isValidationEnabled) {
                                final result =
                                    _controller.validatePassword(text);
                                return result;
                              } else
                                return null;
                            },
                            onChanged: (text) {
                              setState(() {
                                isTouched = true;
                              });
                              _controller.validatePassword(text);
                            },
                          );
                        }),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Por favor, escolha uma senha \n de 6 a 30 caracteres',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.thirthFont,
                                fontFamily: 'Nunito'),
                          ),
                        )
                      ],
                    )),
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
                            text: "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled
                                ? null
                                : () {
                                    _controller.profile.password =
                                        _passwordController.text;
                                    if (_controller.currentPicture != "")
                                      _controller.setPage(2);
                                    else
                                      _controller.setPage(3);
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
