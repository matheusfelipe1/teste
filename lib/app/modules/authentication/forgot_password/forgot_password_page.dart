import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/widgets/email_page.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/widgets/code_page.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/widgets/error_page.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/widgets/password_page.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

// Pages

import 'package:joinder_app/app/shared/util/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ForgotPasswordController>();
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
        children: <Widget>[
          EmailPage(),
          CodePage(),
          PasswordPage(),
        ],
      );
    else {
      return ErrorPage();
    }
  }
}
