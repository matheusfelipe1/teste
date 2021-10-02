import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/validators/validators.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class BirthDatePage extends StatefulWidget {
  @override
  _BirthDatePageState createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  SignUpController _controller;
  TextEditingController _birthDateController;

  FocusNode focusNode;
  bool isTouched = false;
  bool isValidationEnabled = false;
  
  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _birthDateController = new TextEditingController();
    if (_controller.profile.birth == null) {
      _controller.profile.birth = new Birth();
    }
    if (_controller.profile.birth.date != null) {
      var dateQuebrada =
          _controller.profile.birth.date.toString().split(' ')[0].split('-');
      _birthDateController.text =
          dateQuebrada[2] + '/' + dateQuebrada[1] + '/' + dateQuebrada[0];
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
                setState(() {
                  _controller.isButtonDisabled = false;
                })
              });
    } else {
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
                setState(() {
                  _controller.isButtonDisabled = true;
                })
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    JihTip(
                      imagePath: "assets/images/jih4.png",
                      text:
                          "Agora é o início da\nconexão com os astros.\nQual é a data do seu\nnascimento?",
                    ),
                    Padding(
                      child: Text(
                        'Dia que nasci',
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
                          controller: _birthDateController,
                          hintText: "DD/MM/YYYY",
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          focusNode: focusNode,
                          mask: "##/##/####",
                          validator: (text) {
                            if (isTouched && isValidationEnabled) {
                              final result =
                                  _controller.validateBirthDate(text);
                              return result;
                            } else
                              return null;
                          },
                          onChanged: (text) {
                            isTouched = true;
                            _controller.validateBirthDate(text);
                          },
                        );
                      }),
                    ),
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
                            text: "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled
                                ? null
                                : () {
                                    _controller.profile.birth.date =
                                        Validators.formatDate(
                                                _birthDateController.text
                                                    .toString(),
                                                'string')
                                            .toString().split(' ')[0];
                                    _controller.setPage(6);
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
