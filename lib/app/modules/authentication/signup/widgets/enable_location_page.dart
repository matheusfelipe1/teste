import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import '../signup_controller.dart';

class EnableLocationPage extends StatefulWidget {
  @override
  _EnableLocationPageState createState() => _EnableLocationPageState();
}

class _EnableLocationPageState extends State<EnableLocationPage> {
  SignUpController _controller;

  @override
  Future<void> initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: AppColors.backgroundBlueLocation,
        child: Stack(
          children: <Widget>[
            // Align(
            //     alignment: Alignment.center,
            //     child: Container(
            //         padding: EdgeInsets.only(bottom: 60),
            //         child: Opacity(
            //           opacity: 0.6,
            //           child: Image.asset(
            //             'assets/images/estrelas.png',
            //           ),
            //         ))),
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(bottom: 110),
                  child: Image.asset(
                    'assets/images/pulse_location.gif',
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/jih1.png',
                    height: 130,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 60),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Você precisa ativar sua localização\n para usar o joinder.me',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 13,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: 140,
                    child: PrimaryButton(
                      text: "ATIVAR LOCALIZAÇÃO",
                      onPressed: () {
                        Modular.to.pushReplacementNamed('/auth/active-account');
                      },
                    ),
                  ),
                ))
          ],
        ));
  }
}
