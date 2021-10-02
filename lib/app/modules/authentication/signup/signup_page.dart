import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/password_page.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

// Pages
import 'package:joinder_app/app/modules/authentication/signup/widgets/email_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/enable_location_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/interests_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/name_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/picture_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/get_picture_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/about_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/birthdate_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/birthhour_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/birthcity_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/i_am_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/looking_for_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/error_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/seek_page.dart';
import 'package:joinder_app/app/modules/authentication/signup/widgets/ways_of_love_page.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.profile = new Profile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_controller.hasError) {
          if (_controller.page == 0) {
            Modular.get<AuthController>().signOut();
            Navigator.of(context).pop(true);
          }
          else
            _controller.onBack();
        }
      },
      child: Scaffold(
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
              if (!_controller.hasError) {
                if (_controller.page == 0)
                  Navigator.of(context).pop(true);
                else
                  _controller.onBack();
              }
            },
          ),
        ),
        body: SafeArea(
          child: _buildContent(),
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
        children: <Widget>[
          NamePage(),
          PasswordPage(),
          PicturePage(),
          GetPicturePage(),
          AboutPage(),
          BirthDatePage(),
          BirthHourPage(),
          BirthCityPage(),
          IAmPage(),
          LookingForPage(),
          InterestsPage(),
          WaysOfLovesPage(),
          SeekPage(),
          EmailPage(),
          // TODO: Verificar funcionalidade de enviar localização.
          EnableLocationPage(),
        ],
      );
    else {
      return ErrorPage();
    }
  }
}
