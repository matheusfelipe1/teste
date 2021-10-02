import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

class WantToDoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Material(
            color: AppColors.backgroundDialog,
            elevation: 0,
            child: _dialogContent(context),
          )),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 11),
          color: AppColors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //     child: Image.asset(
                    //       'assets/images/back_purple_chat.png',
                    //       width: 25,
                    //     )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/images/close.png',
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: AppColors.support3))),
                  child: Text(
                    'O que deseja fazer?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.mainFont,
                        fontFamily: 'Nunito',
                        fontSize: 30.0),
                  )),
              GestureDetector(
                  onTap: () async {
                    final result = await AppUtils.optionsDialog(
                      context,
                      true,
                      titleCustom: 'TEM CERTEZA QUE QUER',
                      titleBold: 'DAR UM GELO NESSA PESSOA',
                      titlePurple: 'Conte-nos o motivo',
                      image: 'assets/images/ice.png',
                      ice: true,
                      buttonText: "DAR GELO",
                    );
                    Navigator.of(context).pop({'option': 1, 'desc': result});
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: AppColors.support3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Dar Gelo',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.mainFont,
                                fontFamily: 'Nunito',
                                fontSize: 14.0),
                          ),
                          Image.asset(
                            'assets/images/ice.png',
                            width: 20,
                          )
                        ],
                      ))),
              GestureDetector(
                  onTap: () async {
                    final result = await AppUtils.optionsDialog(
                      context,
                      true,
                      titleBold: 'A GENTE NÃO VAI CONTAR \nNINGUÉM',
                      titlePurple: 'DENUNCIAR',
                      image: 'assets/images/ic_denunciar_topo.png',
                      ice: false,
                      buttonText: "DENUNCIAR",
                    );
                    Navigator.of(context).pop({'option': 2, 'desc': result});
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: AppColors.support3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Denunciar',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.mainFont,
                                fontFamily: 'Nunito',
                                fontSize: 14.0),
                          ),
                          Image.asset(
                            'assets/images/ic_denunciar.png',
                            width: 15,
                          )
                        ],
                      ))),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Modular.to.pushNamed('/chat/fridge');
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: AppColors.support3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Ir na Geladeira',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.mainFont,
                              fontFamily: 'Nunito',
                              fontSize: 14.0),
                        ),
                        Image.asset(
                          'assets/images/ic_geladeira.png',
                          width: 15,
                        )
                      ],
                    )),
              ),
              _getButton(context)
            ],
          ),
        )
      ],
    );
  }

  Widget _getButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 11.0),
      width: 150,
      height: 50,
      child: PrimaryButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'CANCELAR',
      ),
    );
  }
}
