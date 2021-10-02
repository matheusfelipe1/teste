import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/phone_auth/phone_auth_controller.dart';
import 'package:joinder_app/app/modules/authentication/phone_auth/widgets/phone_code_page.dart';
import 'package:joinder_app/app/modules/authentication/phone_auth/widgets/phone_input_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/error_page.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  PhoneAuthController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<PhoneAuthController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Observer(
          builder: (_) {
            return Text(
              _controller.pageTitle,
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            );
          },
        ),
        backgroundColor: AppColors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_controller.page == 0)
              Navigator.of(context).pop(true);
            else
              _controller.onBack();
          },
        ),
      ),
      body: SafeArea(
        child: _buildContent(),
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
        children: <Widget>[PhoneInputPage(), PhoneCodePage()],
      );
    else {
      return ErrorPage();
    }
  }
}
