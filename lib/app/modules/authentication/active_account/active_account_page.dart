import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class ActiveAccountPage extends StatefulWidget {
  @override
  _ActiveAccountPageState createState() => _ActiveAccountPageState();
}

class _ActiveAccountPageState extends State<ActiveAccountPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      return {
        Modular.to.pushReplacementNamed('/home'),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.jihGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/jih1.png',
              height: 130,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
            child: Text(
              'Conta ativa.\nAgora, que venham os joinders com compatibilidade para aquela conversa especial!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Nunito'),
            ),
          )
        ],
      ),
    );
  }
}
