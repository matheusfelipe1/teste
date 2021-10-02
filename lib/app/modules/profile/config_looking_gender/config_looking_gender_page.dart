import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';
import 'package:joinder_app/app/shared/widgets/custom_checkbox.dart';

import '../profile_controller.dart';

class ConfigLookingGenderPage extends StatefulWidget {
  @override
  _ConfigLookingGenderPageState createState() =>
      _ConfigLookingGenderPageState();
}

class _ConfigLookingGenderPageState extends State<ConfigLookingGenderPage> {
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _controller.getUserProfile(true);
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
              actions: <Widget>[
                Observer(
                  builder: (_) {
                    if (_controller.profile.lookingFor != null) {
                      return FlatButton(
                        child: Text(
                          "SALVAR",
                          style: TextStyle(
                              color: _controller.profile.lookingFor.length > 0
                                  ? AppColors.white
                                  : Colors.grey,
                              fontSize: 12.0,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          if (_controller.profile != null &&
                              _controller.profile.lookingFor.length > 0) {
                            _controller
                                .savePartialProfile(context, ["looking_for"]);
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
            body: Observer(
              builder: (_) {
                if (!_controller.isLoading) {
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 29.0,
                                      bottom: 21.0,
                                      right: 22,
                                      left: 22.0),
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
                                Container(
                                  color: AppColors.formBorder,
                                  height: 1.0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 19.0,
                                      right: 22,
                                      left: 22.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/config_gender.png',
                                        height: 17.0,
                                      ),
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
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 15),
                                  child: AlwaysVisibleScrollbar.grid(
                                      crossAxisCount: 2,
                                      padding: EdgeInsets.only(
                                          top: 0.0, left: 23.0, right: 23),
                                      scrollDirection: Axis.vertical,
                                      childAspectRatio: 3,
                                      children: _controller.map<Widget>(
                                          _controller.genres, (index, genre) {
                                        return CustomCheckbox(
                                          onChanged: (val) {
                                            setState(() {
                                              _controller
                                                  .addOrRemoveSelectedLookingFor(
                                                      genre.id, val);
                                            });
                                          },
                                          text: _controller
                                              .textWithFirstLetterUppercase(
                                                  genre.label),
                                          value: _controller
                                                      .profile.lookingFor !=
                                                  null
                                              ? _controller.profile.lookingFor
                                                      .where((valuePosition) =>
                                                          valuePosition ==
                                                          genre.id)
                                                      .length >
                                                  0
                                              : false,
                                        );
                                      })),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
