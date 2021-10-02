import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:joinder_app/app/modules/profile/config_phone/config_phone_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class ConfigCodePage extends StatefulWidget {
  @override
  _ConfigCodePageState createState() => _ConfigCodePageState();
}

class _ConfigCodePageState extends State<ConfigCodePage> {
  ConfigPhoneController _controller;
  TextEditingController _pinController;
  String _value = "";

  @override
  void initState() {
    _controller = Modular.get<ConfigPhoneController>();
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
                        Container(
                          width: 150,
                          child: Text(
                            '+55 31 99126-7898',
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
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {},
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
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                child: PinCodeTextField(
                  length: 6,
                  animationType: AnimationType.fade,
                  enableActiveFill: true,
                  controller: _pinController,
                  // fieldWidth: 35.0,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  textStyle: TextStyle(
                      color: AppColors.firstFont,
                      fontSize: 20.0,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700),
                  // borderWidth: 1,
                  textInputType: TextInputType.number,
                  // activeFillColor: Colors.transparent,
                  // inactiveFillColor: Colors.transparent,
                  // activeColor: AppColors.support2,
                  // inactiveColor: AppColors.support2,
                  // selectedColor: AppColors.purple,
                  // selectedFillColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  onCompleted: (v) {
                    _controller.completed = true;
                  },
                  onChanged: (text) {
                    setState(() {
                      _value = text;
                    });
                  },
                )),
            if (_value.length == 6)
              Column(
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
              ),
          ],
        ),
      ],
    );
  }
}
