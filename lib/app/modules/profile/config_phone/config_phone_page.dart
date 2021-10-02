import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/profile/config_phone/widgets/config_code_page.dart';
import 'package:joinder_app/app/modules/profile/config_phone/widgets/config_input_page.dart';
import 'package:joinder_app/app/modules/profile/config_phone/widgets/error_page.dart';

import 'package:joinder_app/app/modules/profile/config_phone/config_phone_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

class ConfigPhonePage extends StatefulWidget {
  @override
  _ConfigPhonePageState createState() => _ConfigPhonePageState();
}

class _ConfigPhonePageState extends State<ConfigPhonePage> {
  ConfigPhoneController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ConfigPhoneController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkPurple,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Observer(
              builder: (_) {
                return Text(
                  _controller.pageTitle,
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: "Nunito",
                      fontSize: 20.0),
                );
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: AppColors.configGradient),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (_controller.page == 0)
                  Modular.to.pop(true);
                else
                  _controller.onBack();
              },
            ),
            actions: <Widget>[
              Observer(
                builder: (_) {
                  if (_controller.page == 0 || _controller.completed)
                    return FlatButton(
                      child: Text(
                        "SALVAR",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.0,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () async {
                        if (_controller.page == 0) {
                          await AppUtils.defaultDialog(context, false, "SMS ENVIADO!",
                              "Verifique a sua caixa de mensagens.", true,
                              buttonText: "OK");
                          _controller.setPage(1);
                        } else {
                          Modular.to.pop();
                          _controller.page = 0;
                        }
                      },
                    );
                  else
                    return Container();
                },
              )
            ],
          ),
          body: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (!_controller.hasError)
      return PageView(
        controller: _controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (p) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        children: <Widget>[ConfigInputPage(), ConfigCodePage()],
      );
    else {
      return ErrorPage();
    }
  }
}
