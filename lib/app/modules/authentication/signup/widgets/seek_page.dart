import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/custom_checkbox.dart';
import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import '../signup_controller.dart';

class SeekPage extends StatefulWidget {
  @override
  _SeekPageState createState() => _SeekPageState();
}

class _SeekPageState extends State<SeekPage> {
  SignUpController _controller;
  AuthController _authController;
  List<IdAndLabel> _seeks = [];
  List<String> seeksSelected = [];

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _authController = Modular.get<AuthController>();
    if (_controller.profile.goals == null) {
      _controller.profile.goals = [];
    }
    seeksSelected = _controller.profile.goals;
    if (seeksSelected.length > 0) {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
    _controller.loading = false;
    _controller.getGoals();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              JihTip(
                imagePath: 'assets/images/jih1.png',
                text: "Conte o que busca  no joinder.me",
              ),
              Padding(
                child: Text(
                  'O que busco',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.mainFont,
                    fontSize: 16.0,
                    fontFamily: 'Nunito',
                  ),
                ),
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 34.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60.0, top: 10.0),
                child: Observer(builder: (_) {
                  if (!_controller.loading) {
                    if (_controller.seeks != null &&
                        _controller.seeks.length > 0) {
                      return Column(
                          children: _controller.map<Widget>(_controller.seeks,
                              (index, seek) {
                        bool validacao =
                            _controller.verifySelected(seek.id, seeksSelected);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: CustomCheckbox(
                            text: _controller
                                .textWithFirstLetterUppercase(seek.label),
                            value: validacao,
                            onChanged: (val) {
                              seeksSelected = _controller.addOrRemoveSelected(
                                  seek.id, seeksSelected, val);
                            },
                          ),
                        );
                      }));
                    } else {
                      return Text("Não encontramos nenhuma forma de amar :(");
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
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
                            top: 12.0, bottom: 12.0, left: 12.0, right: 24.0),
                        child: Observer(builder: (_) {
                          return PrimaryButton(
                            text:
                                _controller.sending ? 'SALVANDO...' : "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled ||
                                    _controller.loading || _controller.sending
                                ? null
                                : () {
                                    _controller.profile.goals = seeksSelected;
                                    if (Modular.get<AuthController>()
                                                .facebookProfile ==
                                            null ||
                                        _authController.facebookProfile.email ==
                                            "" ||
                                        _authController.facebookProfile.email ==
                                            null) {
                                      _controller.isButtonDisabled = true;
                                      _controller.setPage(13);
                                    } else {
                                      _controller.profile.email =
                                          _authController.facebookProfile.email;
                                      _controller.saveUser(context);
                                    }
                                  },
                          );
                        }))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
