import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

import '../profile_controller.dart';

class ConfigPrivacyPolicesPage extends StatefulWidget {
  @override
  _ConfigPrivacyPolicesPageState createState() =>
      _ConfigPrivacyPolicesPageState();
}

class _ConfigPrivacyPolicesPageState extends State<ConfigPrivacyPolicesPage> {
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _controller.getPrivacy();
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
                  color: AppColors.white, fontFamily: 'Nunito', fontSize: 20.0),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: AppColors.configGradient),
            ),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 29.0, bottom: 21.0, right: 22, left: 22.0),
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
                      top: 20.0, bottom: 16.0, right: 22, left: 22.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/config_policy.png',
                        height: 17.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 22),
                        child: Text(
                          "Política de privacidade",
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
                Flexible(
                  child: Observer(
                    builder: (_) {
                      if (!_controller.isLoading) {
                        return SingleChildScrollView(
                          child: Html(
                            data: _controller.privacy,
                            onLinkTap: (text) {
                              print(text);
                            },
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.purple)),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
