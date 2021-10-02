import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:joinder_app/app/shared/widgets/signup_text_field.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class BirthCityPage extends StatefulWidget {
  @override
  _BirthCityPageState createState() => _BirthCityPageState();
}

class _BirthCityPageState extends State<BirthCityPage> {
  SignUpController _controller;
  FocusNode _focus = new FocusNode();
  final _dataKey = new GlobalKey();
  TextEditingController _birthCityController;
  int qtdLetters = 0;

  bool isTouched = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _birthCityController = new TextEditingController();
    if (_controller.profile.birth.place == null) {
      _controller.profile.birth.place = new Place(city: null);
    }
    _birthCityController.text = _controller.profile.birth.place.city;
    _focus.addListener(_onFocusChange);

    if (_birthCityController.text != '') {
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
                setState(() {
                  _controller.isButtonDisabled = false;
                })
              });
    } else {
      Future.delayed(
          Duration(milliseconds: 100),
          () => {
                setState(() {
                  _controller.isButtonDisabled = true;
                })
              });
    }
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      Future.delayed(
          Duration(milliseconds: 300),
          () => {
                Scrollable.ensureVisible(_dataKey.currentContext,
                    duration: Duration(milliseconds: 300))
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    JihTip(
                      imagePath: "assets/images/jih6.png",
                      text:
                          "Os astros vão\naproximar quem\ntem tudo a ver com\nvocê !",
                    ),
                    Padding(
                      child: Text(
                        'Onde nasci',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.mainFont,
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 34.0),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Observer(builder: (_) {
                        return TypeAheadFormField(
                            autovalidate: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              autofocus: true,
                              focusNode: _focus,
                              controller: _birthCityController,
                              obscureText: false,
                              style: TextStyle(
                                  color: AppColors.firstFont,
                                  fontSize: 28.0,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700),
                              cursorColor: AppColors.firstFont,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: AppColors.formHint,
                                      fontSize: 20.0,
                                      fontFamily: 'Nunito'),
                                  hintText: 'Escreva a cidade que nasceu',
                                  filled: true,
                                  fillColor: AppColors.support3,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: AppColors.formBorder,
                                          width: 2.0,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: AppColors.formBorder,
                                          width: 2.0,
                                          style: BorderStyle.solid))),
                            ),
                            errorBuilder: (context, object) {
                              setState(() {
                                _controller.isButtonDisabled = true;
                              });
                              if (qtdLetters > 2) {
                                return Container(
                                  color: AppColors.error,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.only(
                                        left: 20.0, top: 5.0, bottom: 5.0),
                                    leading: Image.asset(
                                      'assets/images/ic_alerta_branco.png',
                                      width: 22,
                                    ),
                                    title: Text(
                                      'Não encontramos a sua cidade. \nVerifique se foi escrita corretamente',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.0),
                                    ),
                                    trailing: IconButton(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      color: AppColors.white,
                                      iconSize: 15.0,
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _controller.isButtonDisabled = true;
                                        });
                                        _birthCityController.text = "";
                                        _controller.profile.birth.place.city =
                                            "";
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                            suggestionsCallback: (pattern) async {
                              qtdLetters = pattern.length;
                              if (!isTouched && !_controller.isButtonDisabled) {
                                setState(() {
                                  isTouched = true;
                                  _controller.isButtonDisabled = true;
                                });
                              }
                              if (qtdLetters > 2) {
                                _controller.loading = true;
                                circularProgressIndicator();
                                return await _controller
                                    .getCitiesSuggestions(pattern);
                              } else
                                return new List<String>();
                            },
                            noItemsFoundBuilder: (context) {
                              _controller.isButtonDisabled = true;
                              if (qtdLetters > 2 && !_controller.loading) {
                                return Container(
                                  color: AppColors.error,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.only(
                                        left: 20.0, top: 5.0, bottom: 5.0),
                                    leading: Image.asset(
                                      'assets/images/ic_alerta_branco.png',
                                      width: 22,
                                    ),
                                    title: Text(
                                      'Não encontramos a sua cidade. \nVerifique se foi escrita corretamente',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.0),
                                    ),
                                    trailing: IconButton(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      color: AppColors.white,
                                      iconSize: 15.0,
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _controller.isButtonDisabled = true;
                                        });
                                        _birthCityController.text = "";
                                        _controller.profile.birth.place.city =
                                            "";
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                            itemBuilder: (context, suggestion) {
                              if (_controller.cities != null)
                                return Container(
                                  color:
                                      _controller.cities.indexOf(suggestion) %
                                                  2 ==
                                              0
                                          ? AppColors.support3
                                          : AppColors.white,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                    title: Text(
                                      suggestion,
                                      style: TextStyle(
                                          color: AppColors.firstFont,
                                          fontSize: 20.0,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                );
                              else
                                return null;
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                _controller.isButtonDisabled = false;
                              });
                              _birthCityController.text = suggestion;
                              _controller.profile.birth.place.city = suggestion;
                            },
                            onSaved: (value) {
                              setState(() {
                                _controller.isButtonDisabled = false;
                              });
                              _controller.profile.birth.place.city = value;
                              _birthCityController.text = value;
                            });
                      }),
                    ),
                    Padding(
                      key: _dataKey,
                      padding:
                          EdgeInsets.only(left: 55.0, right: 55.0, bottom: 15),
                      child: Text(
                        'Com sua cidade, já saberemos as demais informações sobre seu estado e país.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.thirthFont,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Divider(
                      height: 2,
                      color: AppColors.dividerBorder,
                      thickness: 1,
                    ),
                    Container(
                      width: 155,
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Observer(builder: (_) {
                        return PrimaryButton(
                          text: "PRÓXIMO",
                          onPressed: _controller.isButtonDisabled
                              ? null
                              : () {
                                  setState(() {
                                    _controller.isButtonDisabled = true;
                                  });
                                  _controller.profile.birth.place.city =
                                      _birthCityController.text;
                                  _controller.setPage(8);
                                },
                        );
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  circularProgressIndicator() {
    if (_controller.loading) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }
}
