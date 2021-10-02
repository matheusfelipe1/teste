import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/enums/auth_status.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:joinder_app/app/modules/authentication/phone_auth/phone_auth_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class PhoneCodePage extends StatefulWidget {
  @override
  _PhoneCodePageState createState() => _PhoneCodePageState();
}

class _PhoneCodePageState extends State<PhoneCodePage> {
  PhoneAuthController _controller;
  TextEditingController _pinController;
  String _value = "";

  @override
  void initState() {
    _controller = Modular.get<PhoneAuthController>();
    _pinController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
                    child: Row(
                      children: <Widget>[
                        Observer(
                          builder: (_) {
                            return Container(
                              width: 150,
                              child: Text(
                                '+55 ${_controller.phoneNumber}',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.mainFont,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                _value = "";
                              });
                              _controller.smsResult = AuthStatus.loading;
                              _controller.isLoading = false;
                              _controller.submitPhone(context);
                            },
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'REENVIAR',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.thirthMain,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            // Padding(
            //     padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
            //     child:
            // PinCodeTextField(
            //   length: 6,
            //   animationType: AnimationType.fade,
            //   enableActiveFill: true,
            //   controller: _pinController,
            //   fieldWidth: 35.0,
            //   inputFormatters: <TextInputFormatter>[
            //     WhitelistingTextInputFormatter.digitsOnly
            //   ],
            //   textStyle: TextStyle(
            //       color: AppColors.firstFont,
            //       fontSize: 20.0,
            //       fontFamily: 'Nunito',
            //       fontWeight: FontWeight.w700),
            //   borderWidth: 1,
            //   textInputType: TextInputType.number,
            //   activeFillColor: Colors.transparent,
            //   inactiveFillColor: Colors.transparent,
            //   activeColor: AppColors.support2,
            //   inactiveColor: AppColors.support2,
            //   selectedColor: AppColors.purple,
            //   selectedFillColor: Colors.transparent,
            //   backgroundColor: Colors.transparent,
            //   onCompleted: (v) {
            //     _controller.submitCode(v);
            //   },
            //   onChanged: (text) {
            //     setState(() {
            //       _value = text;
            //     });
            //   },
            // )
            // ),
            Observer(
              builder: (_) {
                if (_controller.isLoading) {
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.purple)),
                        ),
                      )
                    ],
                  );
                } else {
                  if (_controller.smsResult == AuthStatus.logged) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: Center(
                              child: Image.asset(
                            'assets/images/ic_check.png',
                            width: 35.0,
                          )),
                        )
                      ],
                    );
                  } else if (_controller.smsResult == AuthStatus.unlogged) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: Center(
                              child: Image.asset(
                            'assets/images/ic_erro.png',
                            width: 35.0,
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: Center(
                              child: Text(
                            "Código inválido.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12.0,
                                fontFamily: 'Nunito'),
                          )),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
              },
            )
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
              child: PrimaryButton(
                text: "PRÓXIMO",
                onPressed: () {
                  Modular.to.pushNamed('/auth/sign-up');
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
