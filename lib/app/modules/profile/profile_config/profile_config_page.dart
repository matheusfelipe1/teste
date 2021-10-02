import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/profile/profile_controller.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

class ProfileConfigPage extends StatefulWidget {
  @override
  _ProfileConfigPageState createState() => _ProfileConfigPageState();
}

class _ProfileConfigPageState extends State<ProfileConfigPage> {
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
            ),
            body: Observer(
              builder: (_) {
                if (!_controller.isLoading) {
                  return Container(
                    color: AppColors.white,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
                    child: ListView(
                      children: <Widget>[
                        // Section 1
                        Container(
                          padding: EdgeInsets.only(
                              top: 33.0, bottom: 0.0, right: 22, left: 22.0),
                          child: Text(
                            "CONFIGURAÇÕES DA CONTA",
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
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed('/profile/config/email');
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                top: 21.0, bottom: 19.0, right: 22, left: 22.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/email.png',
                                  height: 24.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 22),
                                      child: Text(
                                        "E-MAIL",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.mainFont,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 22, top: 8.0),
                                      child: Text(
                                        _controller.profile.email,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.purple,
                                            fontFamily: 'Nunito',
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppColors.formBackground,
                          height: 8.0,
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(
                        //       top: 33.0, bottom: 0.0, right: 22, left: 22.0),
                        //   child: Text(
                        //     "CONFIGURAÇÕES DA CONTA",
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     textAlign: TextAlign.start,
                        //     style: TextStyle(
                        //         color: AppColors.mainFont,
                        //         fontFamily: 'Nunito',
                        //         fontWeight: FontWeight.w700,
                        //         fontSize: 14.0),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Modular.to.pushNamed('/profile/config/phone');
                        //   },
                        //   behavior: HitTestBehavior.opaque,
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     padding: EdgeInsets.only(
                        //         top: 21.0, bottom: 19.0, right: 22, left: 22.0),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Image.asset(
                        //           'assets/images/cellphone.png',
                        //           height: 24.0,
                        //         ),
                        //         Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: <Widget>[
                        //             Container(
                        //               padding: EdgeInsets.only(left: 22),
                        //               child: Text(
                        //                 "NÚMERO DO TELEFONE",
                        //                 maxLines: 1,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 textAlign: TextAlign.start,
                        //                 style: TextStyle(
                        //                     color: AppColors.mainFont,
                        //                     fontFamily: 'Nunito',
                        //                     fontWeight: FontWeight.w700,
                        //                     fontSize: 12.0),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(left: 22, top: 8.0),
                        //               child: Text(
                        //                 "55 31 99126-7898",
                        //                 maxLines: 1,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 textAlign: TextAlign.start,
                        //                 style: TextStyle(
                        //                     color: AppColors.mainFont,
                        //                     fontFamily: 'Nunito',
                        //                     fontSize: 12.0),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   color: AppColors.formBackground,
                        //   height: 8.0,
                        // ),
                        // Section 2

                        Container(
                          padding: EdgeInsets.only(
                              top: 19.0, bottom: 0.0, right: 22, left: 22.0),
                          child: Text(
                            "PROCURAR POR",
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
                        GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/profile/config/gender');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 21.0,
                                  bottom: 19.0,
                                  right: 22,
                                  left: 22.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/config_gender.png',
                                    height: 17.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 22),
                                        child: Text(
                                          "GÊNERO",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: AppColors.mainFont,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          color: AppColors.formBorder,
                          margin: EdgeInsets.only(left: 62.0, right: 23.0),
                          height: 1.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed('/profile/config/filters');
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 21.0, bottom: 19.0, right: 22, left: 22.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/config_filters.png',
                                  height: 17.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 22),
                                      child: Text(
                                        "OUTROS FILTROS",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.mainFont,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 22, top: 8.0),
                                      child: Text(
                                        "Idade e distância",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.mainFont,
                                            fontFamily: 'Nunito',
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppColors.formBackground,
                          height: 8.0,
                        ),
                        // Section 3
                        Container(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, right: 22, left: 22.0),
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
                        GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/profile/config/feedback');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 21.0,
                                  bottom: 19.0,
                                  right: 22,
                                  left: 22.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/config_feedback.png',
                                    height: 17.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
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
                                ],
                              ),
                            )),
                        Container(
                          color: AppColors.formBorder,
                          margin: EdgeInsets.only(left: 62.0, right: 23.0),
                          height: 1.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/profile/config/politics');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 19.5,
                                  bottom: 19.0,
                                  right: 22,
                                  left: 22.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/config_policy.png',
                                    height: 17.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
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
                                ],
                              ),
                            )),
                        Container(
                          color: AppColors.formBorder,
                          margin: EdgeInsets.only(left: 62.0, right: 23.0),
                          height: 1.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/profile/config/service');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 19.5,
                                  bottom: 19.0,
                                  right: 22,
                                  left: 22.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/config_terms.png',
                                    height: 17.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 22),
                                        child: Text(
                                          "Termos de uso",
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
                                ],
                              ),
                            )),
                        Container(
                          color: AppColors.formBorder,
                          margin: EdgeInsets.only(left: 62.0, right: 23.0),
                          height: 1.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await AppUtils.asyncConfirmDialog(
                                context,
                                'assets/images/ic_carinha_delete.png',
                                'DESEJA SAIR',
                                'Que triste.\nTem certeza que deseja sair?',
                                'ATENÇÃO: Manteremos sua\nconta, seu perfil, suas mensagens\ne fotos.',
                                'CANCELAR',
                                'SAIR')) {
                              Modular.get<AuthController>().signOut();
                            }
                          },
                          child: Container(
                            // Não retirar o 'color'. Isso possibilita o clique em toda a linha e não somente na escrita
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                top: 19.5, bottom: 19.0, right: 22, left: 22.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/config_logout.png',
                                  height: 17.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 22),
                                      child: Text(
                                        "Sair",
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppColors.formBorder,
                          margin: EdgeInsets.only(left: 62.0, right: 23.0),
                          height: 1.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = await AppUtils.optionsConfigDialog(
                              context,
                              true,
                              titleCustom: 'TEM CERTEZA QUE QUER',
                              titleBold: 'DELETAR SUA CONTA?',
                              titlePurple: 'Conte-nos o motivo',
                              titleObs:
                                  'ATENÇÃO: Excluiremos sua conta,\nseu perfil, suas mensagens e fotos.',
                              image: 'assets/images/ic_carinha_delete.png',
                              buttonText: "DELETAR",
                            );
                            if (result != "cancelled")
                              _controller.deleteProfile(context, result);
                          },
                          child: Container(
                            // Não retirar o 'color'. Isso possibilita o clique em toda a linha e não somente na escrita
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                top: 19.5, bottom: 19.0, right: 22, left: 22.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/config_delete.png',
                                  height: 17.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 22),
                                      child: Text(
                                        "Deletar conta",
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
                              ],
                            ),
                          ),
                        )
                      ],
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
