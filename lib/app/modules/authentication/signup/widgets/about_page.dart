import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/signup_box_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  SignUpController _controller;
  TextEditingController _aboutController;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _aboutController = new TextEditingController();
    _aboutController.text =
        _controller.profile.about != null ? _controller.profile.about : '';
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
                  imagePath: "assets/images/jih3.png",
                  text:
                      "Escreva sobre você\ne deixe que as pessoas\nte conheçam de\nverdade!",
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Escreva sobre você",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0, color: AppColors.mainFont),
                        ),
                      ),
                      Container(
                        child: Observer(builder: (_) {
                          return SignUpBoxField(
                            autocorrect: false,
                            autovalidate: true,
                            enable: true,
                            autofocus: false,
                            colorFont: AppColors.formHint,
                            background: AppColors.support3,
                            maxLines: _getNumberOfLines(),
                            controller: _aboutController,
                            hintText: "Ex: O que gosto? O que busco...",
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            validator: (text) {
                              final result = _controller.validateAbout(text);
                              _controller.isButtonDisabled =
                                  result == null ? false : true;
                              return result;
                            },
                            onChanged: (text) {
                              final result = _controller.validateAbout(text);
                              _controller.isButtonDisabled =
                                  result == null ? false : true;
                            },
                          );
                        }),
                      )
                    ],
                  ),
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
                              text: "PULAR",
                              onPressed: () {
                                _controller.setPage(5);
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
                                          _controller.profile.about =
                                              _aboutController.text.toString();
                                          _controller.setPage(5);
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

  int _getNumberOfLines() {
    final height = MediaQuery.of(context).size.height * 0.5419;
    final cellHeight = MediaQuery.of(context).size.height * 0.0903;
    return height ~/ cellHeight;
  }
}
