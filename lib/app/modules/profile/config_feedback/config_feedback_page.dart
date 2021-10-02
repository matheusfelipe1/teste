import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/modules/profile/profile_controller.dart';
import 'package:joinder_app/app/shared/widgets/signup_box_field.dart';

class ConfigFeedbackPage extends StatefulWidget {
  @override
  _ConfigFeedbackPageState createState() => _ConfigFeedbackPageState();
}

class _ConfigFeedbackPageState extends State<ConfigFeedbackPage> {
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Configurações",
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Nunito',
                    fontSize: 20.0),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: AppColors.configGradient),
              ),
              actions: <Widget>[
                Observer(
                  builder: (_) {
                    return FlatButton(
                      child: Text(
                        "SALVAR",
                        style: TextStyle(
                            color: (_controller.feedback == null || _controller.feedback.length == 0)
                                ? Colors.grey
                                : AppColors.white,
                            fontSize: 12.0,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () async {
                        if (_controller.feedback != null && _controller.feedback.length > 0)
                          _controller.sendFeedback(context);
                      },
                    );
                  },
                )
              ],
            ),
            body: Observer(
              builder: (_) {
                if (!_controller.isLoading) {
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 29.0,
                                      bottom: 21.0,
                                      right: 22,
                                      left: 22.0),
                                  child: Text(
                                    "MINHA CONTA",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: AppColors.mainFont,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  color: AppColors.formBorder,
                                  height: 1.0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 16.0,
                                      right: 22,
                                      left: 22.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/config_feedback.png',
                                        height: 17.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 22),
                                        child: Text(
                                          "Feedback",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: AppColors.mainFont,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 23),
                                  child: Material(
                                      child: SignUpBoxField(
                                    autocorrect: false,
                                    autovalidate: true,
                                    enable: true,
                                    autofocus: false,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 18),
                                    colorFont: AppColors.fontGrayLight,
                                    background: AppColors.formBackground,
                                    maxLines: 6,
                                    controller: _controller.feedbackController,
                                    hintText:
                                        "Escreva aqui o que você está achando do joinder.me? Nos ajude a melhorar, ou mesmo dê aquela elogiada para ficarmos felizes :D",
                                    keyboardType: TextInputType.text,
                                    obscureText: false,
                                    onChanged: (text) {
                                      setState(() {
                                        _controller.feedback = text;
                                      });
                                    },
                                    validator: (_) {},
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
