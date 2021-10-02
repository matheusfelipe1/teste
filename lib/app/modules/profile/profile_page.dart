import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/profile/profile_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _controller.getUserProfile(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.purple,
      child: SafeArea(
          bottom: false,
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10,
                left: 15,
                right: 15),
            color: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset('assets/images/profile_custom.png'),
                        iconSize: 41.0,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/cards_purple.png'),
                        iconSize: 41.0,
                        onPressed: () {
                          Modular.to.pushReplacementNamed('/home');
                        },
                      ),
                    ],
                  ),
                ),
                Observer(
                  builder: (_) {
                    if (!_controller.isLoading)
                      return Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.7,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    style: BorderStyle.solid,
                                    color:
                                        AppColors.getSignColor(AppUtils.getSign(_controller.profile))),
                                borderRadius: BorderRadius.circular(500)),
                            child: CachedNetworkImage(
                                imageUrl: _controller.profile.photos.first,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                      backgroundColor: AppColors.white,
                                      maxRadius: 100,
                                      minRadius: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          child: Image(image: imageProvider, width: MediaQuery.of(context).size.width * 0.7, fit: BoxFit.cover,),
                                          ),
                                    ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.purple)),
                                errorWidget: (context, url, error) {
                                  return Column(
                                    children: <Widget>[
                                      Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, left: 15.0, right: 15.0),
                                        child: Text(
                                          "Erro ao carregar sua foto :(",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Nunito',
                                              fontSize: 14.0),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 18),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Olá\n",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.mainFontOpacity9,
                                      fontSize: 18,
                                      fontFamily: 'Nunito'),
                                ),
                                TextSpan(
                                  text: _controller.profile.name,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.mainFont,
                                      height: 1.2,
                                      fontSize: 30,
                                      fontFamily: 'Nunito'),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 18),
                            child: Text(
                              AppUtils.getSign(_controller.profile),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 56.0,
                                  fontFamily: 'Shink',
                                  color: AppColors.getSignColor(AppUtils.getSign(_controller.profile)),
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ],
                      );
                    else
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.purple)),
                      );
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: _outlineButton("EDITAR PERFIL",
                            'assets/images/edit.png', '/profile/edit'),
                      ),
                      Container(
                        child: _outlineButton("CONFIGURAÇÕES",
                            'assets/images/settings.png', '/profile/config'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }

  Widget _outlineButton(text, icon, route) {
    return OutlineButton(
        borderSide: BorderSide(color: AppColors.mainBorder, width: 2.0),
        highlightedBorderColor: AppColors.mainBorder,
        highlightColor: AppColors.mainBorder,
        color: AppColors.white,
        padding: EdgeInsets.only(top: 11.5, bottom: 11.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () {
          Modular.to.pushNamed(route);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    color: AppColors.firstFont,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w800,
                    fontSize: 11.0),
              ),
            ],
          ),
        ));
  }
}
