import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class BirthHourPage extends StatefulWidget {
  @override
  _BirthHourPageState createState() => _BirthHourPageState();
}

class _BirthHourPageState extends State<BirthHourPage> {
  SignUpController _controller;
  TextEditingController _birthHourController;

  FocusNode focusNode;
  bool isValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _birthHourController = new TextEditingController();
    if (_controller.profile.birth.time != null)
      _birthHourController.text = _controller.profile.birth.time.toString();

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    JihTip(
                      imagePath: "assets/images/jih5.png",
                      text:
                          "Que horas você\nnasceu? Se não souber,\npreencha depois.",
                    ),
                    Padding(
                      child: Text(
                        'Horas que nasci',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.mainFont,
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 34.0),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Observer(builder: (_) {
                        return SignUpTextField(
                          autocorrect: false,
                          autovalidate: true,
                          focusNode: focusNode,
                          controller: _birthHourController,
                          hintText: "Hora de nascimento",
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          mask: "##:##",
                          validator: (text) {
                            if (isValidationEnabled && text != "") {
                              final result =
                                  _controller.validateBirthHour(text);
                              return result;
                            } else
                              return null;
                          },
                          onChanged: (text) {
                            _controller.validateBirthHour(text);
                          },
                        );
                      }),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15),
                      child: Text(
                        'Procure em sua certidão de nascimento ou sua\nfamília pode saber.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.thirthFont,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Nunito',
                        ),
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 24.0,
                                right: 12.0),
                            child: CustomOutlineButton(
                              text: "NÃO SEI",
                              onPressed: () {
                                setState(() {
                                  _controller.isButtonDisabled = true;
                                });
                                _controller.profile.birth.time = "00:00";
                                _controller.setPage(7);
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 12.0,
                                right: 24.0),
                            child: Observer(builder: (_) {
                              return PrimaryButton(
                                  text: "PRÓXIMO",
                                  onPressed: _controller.isButtonDisabled
                                      ? null
                                      : () {
                                          setState(() {
                                            _controller.isButtonDisabled = true;
                                          });
                                          _controller.profile.birth.time =
                                              _birthHourController.text
                                                  .toString();
                                          _controller.setPage(7);
                                        });
                            }),
                          )
                        ],
                      ),
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
