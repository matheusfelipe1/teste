import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  SignUpController _controller;
  TextEditingController _nameController;
  AuthController _authController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _authController = Modular.get<AuthController>();
    _nameController = new TextEditingController();
    _nameController.text = _controller.profile.name != null
        ? _controller.profile.name
        : _authController.facebookProfile != null
            ? _authController.facebookProfile.name
            : '';
    if (_nameController.text != '')
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
                setState(() {
                  _controller.isButtonDisabled = false;
                })
              });
    else
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                JihTip(
                  imagePath: "assets/images/jih1.png",
                  text: "Meu nome é Jih.\nE o seu?",
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Observer(builder: (_) {
                    return SignUpTextField(
                      autocorrect: true,
                      autovalidate: true,
                      controller: _nameController,
                      hintText: "Meu nome é",
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      focusNode: focusNode,
                      obscureText: false,
                      validator: (text) {
                        if (isTouched && isValidationEnabled) {
                          final result = _controller.validateName(text);
                          return result;
                        } else
                          return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          isTouched = true;
                        });
                        _controller.validateName(text);
                      },
                    );
                  }),
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
                            text: "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled
                                ? null
                                : () {
                                    _controller.profile.name =
                                        _nameController.text.toString();

                                    if (Modular.get<AuthController>()
                                                .facebookProfile ==
                                            null &&
                                        Modular.get<AuthController>()
                                                .currentUser ==
                                            null) {
                                      _controller.setPage(1);
                                    } else if (_controller.currentPicture !=
                                        "") {
                                      _controller.setPage(2);
                                    } else if (Modular.get<AuthController>()
                                                .facebookProfile !=
                                            null &&
                                        Modular.get<AuthController>()
                                                .facebookProfile
                                                .picture !=
                                            null &&
                                        Modular.get<AuthController>()
                                                .facebookProfile
                                                .picture !=
                                            "") {
                                      _controller.currentPicture =
                                          Modular.get<AuthController>()
                                              .facebookProfile
                                              .picture;
                                      _controller.setPage(2);
                                    } else {
                                      _controller.setPage(3);
                                    }
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
