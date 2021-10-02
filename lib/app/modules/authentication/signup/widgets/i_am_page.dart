import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';

import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';
import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/widgets/custom_checkbox.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class IAmPage extends StatefulWidget {
  @override
  _IAmPageState createState() => _IAmPageState();
}

class _IAmPageState extends State<IAmPage> {
  SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    if (_controller.profile.genders == null) {
      _controller.profile.genders = [];
    }
    _controller.genresIAm = ObservableList.of(_controller.profile.genders);
    if (_controller.genresIAm.length > 0) {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
    _controller.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            JihTip(
              imagePath: "assets/images/jih7.png",
              text: "Precisamos\nconhecer você um\npouquinho mais.",
            ),
            Flexible(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Observer(
                      builder: (_) {
                        if (!_controller.loading) {
                          if (_controller.genres != null &&
                              _controller.genres.length > 0) {
                            return AlwaysVisibleScrollbar.grid(
                                crossAxisCount: 2,
                                padding: EdgeInsets.only(
                                    top: 0.0, left: 23.0, right: 23),
                                scrollDirection: Axis.vertical,
                                childAspectRatio: 3,
                                children: _controller.map<Widget>(
                                    _controller.genres, (index, genre) {
                                  return CustomCheckbox(
                                    onChanged: (val) {
                                      _controller.genresIAm =
                                          new ObservableList.of(
                                              _controller.addOrRemoveSelected(
                                                  genre.id,
                                                  _controller.genresIAm,
                                                  val));
                                    },
                                    text: _controller
                                        .textWithFirstLetterUppercase(
                                            genre.label),
                                    value: _controller.genresIAm != null
                                        ? _controller.genresIAm
                                                .where((valuePosition) =>
                                                    valuePosition == genre.id)
                                                .length >
                                            0
                                        : false,
                                  );
                                }));
                          } else {
                            return Text("Não encontramos nenhum gênero :(");
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ))),
            Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Essa informação não será pública.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.thirthFont, fontSize: 12.0),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Não aparecerá em seu perfil.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.thirthFont, fontSize: 12.0),
                    )),
                Divider(
                  height: 2,
                  color: AppColors.dividerBorder,
                  thickness: 1,
                ),
                Container(
                  child: Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 24.0, right: 12.0),
                          child: CustomOutlineButton(
                            text: "LIMPAR",
                            onPressed: () {
                              _controller.genresIAm =
                                  new ObservableList<String>();
                              _controller.profile.genders = [];
                              _controller.getGenres();
                              _controller.isButtonDisabled = true;
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 12.0, right: 24.0),
                          child: PrimaryButton(
                            text: "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled
                                ? null
                                : () {
                                    setState(() {
                                      _controller.isButtonDisabled = true;
                                    });
                                    _controller.profile.genders =
                                        _controller.genresIAm.toList();
                                    _controller.setPage(9);
                                  },
                          ),
                        )
                      ],
                    );
                  }),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
