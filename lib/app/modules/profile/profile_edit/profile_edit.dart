import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:joinder_app/app/modules/profile/profile_controller.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/validators/validators.dart';
import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';
import 'package:joinder_app/app/shared/widgets/draggablegridview/component_draggable_grid_view.dart';
import 'package:joinder_app/app/shared/widgets/profile_text_field.dart';
import 'package:joinder_app/app/shared/widgets/signup_box_field.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:mobx/mobx.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileController _controller;
  final _dataKey = new GlobalKey();

  int qtdLetters = 0;

  bool isAboutTouched = false;

  FocusNode dateFocusNode;
  FocusNode hourFocusNode;
  FocusNode cityFocusNode;
  bool isDateTouched = false;
  bool isHourTouched = false;
  bool isCityTouched = false;
  bool isDateValidationEnabled = false;
  bool isHourValidationEnabled = false;
  bool isCityValidationEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _controller.getUserProfile(true);

    dateFocusNode = new FocusNode();
    dateFocusNode.addListener(() {
      if (!dateFocusNode.hasFocus)
        setState(() {
          isDateValidationEnabled = true;
        });
      else
        setState(() {
          isDateValidationEnabled = false;
        });
    });

    hourFocusNode = new FocusNode();
    hourFocusNode.addListener(() {
      if (!hourFocusNode.hasFocus)
        setState(() {
          isHourValidationEnabled = true;
        });
      else
        setState(() {
          isHourValidationEnabled = false;
        });
    });

    cityFocusNode = new FocusNode();
    cityFocusNode.addListener(() {
      if (!cityFocusNode.hasFocus)
        setState(() {
          isCityValidationEnabled = true;
        });
      else {
        setState(() {
          isCityValidationEnabled = false;
        });
      }
      if (cityFocusNode.hasFocus) {
        Future.delayed(
            Duration(milliseconds: 300),
            () => {
                  Scrollable.ensureVisible(_dataKey.currentContext,
                      duration: Duration(milliseconds: 300))
                });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(child: Observer(
        builder: (_) {
          if (!_controller.isLoading && _controller.profile.photos != null) {
            return SingleChildScrollView(
              child: Container(
                color: AppColors.formBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(22, 8, 22, 31),
                      margin: EdgeInsets.only(bottom: 10),
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    if (!await AppUtils.asyncConfirmDialog(
                                        context,
                                        'assets/images/face.png',
                                        'DESEJA SAIR?',
                                        'Você não esqueceu de salvar?',
                                        'Você pode fazer isso agora ;)',
                                        'NÃO',
                                        'ESQUECI')) {
                                      Modular.to.pop();
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/voltar.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Container(
                                    child: FlatButton(
                                  onPressed: () {
                                    if (_controller.isFormValid) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _controller.profile.birth.date =
                                          Validators.formatDate(
                                                  _controller
                                                      .birthDateController.text
                                                      .toString(),
                                                  'string')
                                              .toString()
                                              .split(' ')[0];
                                      if (_controller.isHourValid) {
                                        _controller.profile.birth.time =
                                            _controller.birthHourController.text
                                                .toString();
                                      } else
                                        _controller.profile.birth.time = "";
                                      _controller.saveProfile(context);
                                    }
                                  },
                                  child: Container(
                                      child: Text(
                                    'SALVAR',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Nunito',
                                        decoration: TextDecoration.none,
                                        color: _controller.isFormValid
                                            ? AppColors.thirthMain
                                            : Colors.grey),
                                  )),
                                )),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(bottom: 0.0, top: 5),
                              width: MediaQuery.of(context).size.width,
                              child: _bindText('Minhas fotos', 16,
                                  AppColors.mainFontOpacity9, TextAlign.left)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 10.0,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.width * 0.45,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: DragAbleGridViewComponent(
                                      photos: _controller.photos_param,
                                      onChanged: (list) {
                                        _controller.profile.photos = list;
                                        _controller.photos_param =
                                            new ObservableList();
                                        if (_controller.profile.photos !=
                                            null) {
                                          var tamanho = _controller
                                                      .profile.photos.length <
                                                  8
                                              ? _controller
                                                      .profile.photos.length +
                                                  1
                                              : 8;
                                          for (var i = 0; i < tamanho; i++) {
                                            if (_controller
                                                    .profile.photos.length >
                                                i) {
                                              _controller.photos_param.add(
                                                  _controller
                                                      .profile.photos[i]);
                                            } else {
                                              _controller.photos_param.add('');
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: _bindText(
                                  'Segure, arraste e solte para reordenar suas fotos.\nTamanho máximo de 1 MB.',
                                  10,
                                  AppColors.fontGrayLight,
                                  TextAlign.left))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(22, 35, 22, 31),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: _bindText('O que busco', 16,
                                AppColors.mainFontOpacity9, TextAlign.left),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.mainBorderOpacity7),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: _controller.profile.goals != null
                                        ? _controller.profile.goals.length >=
                                                    0 &&
                                                _controller
                                                        .profile.goals.length <=
                                                    2
                                            ? 60
                                            : 100
                                        : 0,
                                    color: AppColors.white,
                                    child: Material(
                                      color: AppColors.white,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          child: Observer(
                                            builder: (_) {
                                              if (_controller.profile.goals !=
                                                      null &&
                                                  _controller.profile.goals
                                                          .length >
                                                      0) {
                                                return AlwaysVisibleScrollbar
                                                    .grid(
                                                        crossAxisCount: 2,
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        scrollbarColor:
                                                            AppColors.dialogBox,
                                                        childAspectRatio: 3,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                        children: map<Widget>(
                                                            _controller
                                                                .profile.goals,
                                                            (index, id) {
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .dialogBox,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: AppColors
                                                                        .formBorder),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        7,
                                                                    vertical:
                                                                        5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child:
                                                                      Flexible(
                                                                          child:
                                                                              Text(
                                                                    _controller.textWithFirstLetterUppercase(_controller
                                                                        .seeks
                                                                        .where((seek) =>
                                                                            seek.id ==
                                                                            id)
                                                                        .first
                                                                        .label),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    maxLines: 2,
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        color: AppColors
                                                                            .secondFont),
                                                                  )),
                                                                ),
                                                                Container(
                                                                  width: 20,
                                                                  child:
                                                                      IconButton(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    icon: Image
                                                                        .asset(
                                                                            'assets/images/close.png'),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _controller
                                                                            .profile
                                                                            .goals
                                                                            .removeAt(index);
                                                                      });
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }));
                                              } else {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Por favor adicione uma busca",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .backgroundRed,
                                                          fontSize: 12.0,
                                                          fontFamily: 'Nunito'),
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          )),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 17),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result =
                                            await AppUtils.defaultDialogProfile(
                                                context,
                                                'seek',
                                                _controller.seeks,
                                                _controller.profile.goals);
                                        setState(() {
                                          _controller.profile.goals = result;
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/plus-circle-filled-icon.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.fromLTRB(22, 34, 22, 35),
                        color: AppColors.white,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: _bindText(
                                        'Sobre mim',
                                        16,
                                        AppColors.mainFontOpacity9,
                                        TextAlign.left),
                                  ),
                                  Material(
                                      color: AppColors.white,
                                      child: SignUpBoxField(
                                        autocorrect: false,
                                        autovalidate: true,
                                        enable: true,
                                        autofocus: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 25),
                                        colorFont: AppColors.mainFont,
                                        background: AppColors.formBackground,
                                        maxLines: _getNumberOfLines(),
                                        hintText:
                                            "Ex: O que gosto? O que busco...",
                                        controller: _controller.aboutController,
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        validator: (_) {},
                                        onChanged: (text) {
                                          _controller.profile.about =
                                              _controller.aboutController.text;
                                        },
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(22, 34, 22, 35),
                      margin: EdgeInsets.only(bottom: 10),
                      color: AppColors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 5),
                            child: _bindText('Gênero', 16,
                                AppColors.mainFontOpacity9, TextAlign.left),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.mainBorderOpacity7),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: _controller.profile.genders != null
                                        ? _controller.profile.genders.length >=
                                                    0 &&
                                                _controller.profile.genders
                                                        .length <=
                                                    2
                                            ? 80
                                            : _controller.profile.genders
                                                            .length >
                                                        2 &&
                                                    _controller.profile.genders
                                                            .length <
                                                        5
                                                ? 135
                                                : 190
                                        : 0,
                                    color: AppColors.white,
                                    child: Material(
                                      color: AppColors.white,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          child: Observer(
                                            builder: (_) {
                                              if (_controller.profile.genders !=
                                                      null &&
                                                  _controller.profile.genders
                                                          .length >
                                                      0) {
                                                return AlwaysVisibleScrollbar
                                                    .grid(
                                                        crossAxisCount: 2,
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        scrollbarColor:
                                                            AppColors.dialogBox,
                                                        childAspectRatio: 2,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                        children: map<Widget>(
                                                            _controller.profile
                                                                .genders,
                                                            (index, id) {
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .dialogBox,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: AppColors
                                                                        .formBorder),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        7,
                                                                    vertical:
                                                                        5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child:
                                                                      Flexible(
                                                                          child:
                                                                              Text(
                                                                    _controller.textWithFirstLetterUppercase(_controller
                                                                        .genres
                                                                        .where((genre) =>
                                                                            genre.id ==
                                                                            id)
                                                                        .first
                                                                        .label),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    maxLines: 2,
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        color: AppColors
                                                                            .secondFont),
                                                                  )),
                                                                ),
                                                                Container(
                                                                  width: 20,
                                                                  child:
                                                                      IconButton(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    icon: Image
                                                                        .asset(
                                                                            'assets/images/close.png'),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _controller
                                                                            .profile
                                                                            .genders
                                                                            .removeAt(index);
                                                                      });
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }));
                                              } else {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Por favor adicione um gênero ou mais",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .backgroundRed,
                                                          fontSize: 12.0,
                                                          fontFamily: 'Nunito'),
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          )),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 25),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result =
                                            await AppUtils.defaultDialogProfile(
                                                context,
                                                'genre',
                                                _controller.genres,
                                                _controller.profile.genders);
                                        setState(() {
                                          _controller.profile.genders = result;
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/plus-circle-filled-icon.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(22, 32, 22, 35),
                      margin: EdgeInsets.only(bottom: 10),
                      color: AppColors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 20),
                            child: _bindText(
                                'Insira a data e hora em que nasceu',
                                16,
                                AppColors.mainFontOpacity9,
                                TextAlign.left),
                          ),
                          Material(
                            color: AppColors.white,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: ProfileTextField(
                                autocorrect: false,
                                autovalidate: true,
                                fillColor: AppColors.formBackground,
                                controller: _controller.birthDateController,
                                hintText: "DD/MM/YYYY",
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                focusNode: dateFocusNode,
                                mask: "##/##/####",
                                validator: (text) {
                                  if (isDateTouched &&
                                      isDateValidationEnabled) {
                                    final result =
                                        _controller.validateBirthDate(text);
                                    return result;
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  isDateTouched = true;
                                },
                              ),
                            ),
                          ),
                          Material(
                            child: Container(
                              color: AppColors.white,
                              child: ProfileTextField(
                                autocorrect: false,
                                fillColor: AppColors.formBackground,
                                autovalidate: true,
                                controller: _controller.birthHourController,
                                hintText: "Hora de nascimento",
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                focusNode: hourFocusNode,
                                mask: "##:##",
                                validator: (text) {
                                  if (isHourValidationEnabled && text != "") {
                                    final result =
                                        _controller.validateBirthHour(text);
                                    return result;
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  _controller.validateBirthHour(text);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(22, 32, 22, 35),
                      margin: EdgeInsets.only(bottom: 10),
                      color: AppColors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 20),
                            child: _bindText('Cidade que nasci', 16,
                                AppColors.mainFontOpacity9, TextAlign.left),
                          ),
                          Material(
                            color: AppColors.white,
                            child: Container(
                              key: _dataKey,
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: TypeAheadFormField(
                                  autovalidate: true,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    focusNode: cityFocusNode,
                                    controller: _controller.birthCityController,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: AppColors.formBorder,
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: AppColors.formBorder,
                                                width: 2.0,
                                                style: BorderStyle.solid))),
                                  ),
                                  errorBuilder: (context, object) {
                                    _controller.validateBirthCity(false);
                                    if (qtdLetters > 2) {
                                      return Container(
                                        color: AppColors.error,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.only(
                                              left: 20.0,
                                              top: 5.0,
                                              bottom: 5.0),
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
                                            padding:
                                                EdgeInsets.only(bottom: 20.0),
                                            color: AppColors.white,
                                            iconSize: 15.0,
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              _controller
                                                  .validateBirthCity(false);
                                              _controller.birthCityController
                                                  .text = "";
                                              _controller.profile.birth.place
                                                  .city = "";
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
                                    setState(() {
                                      isCityTouched = true;
                                    });
                                    qtdLetters = pattern.length;
                                    _controller.validateBirthCity(false);
                                    if (qtdLetters > 2) {
                                      _controller.loading = true;
                                      circularProgressIndicator();
                                      return await _controller
                                          .getCitiesSuggestions(pattern);
                                    } else
                                      return new List<String>();
                                  },
                                  noItemsFoundBuilder: (context) {
                                    _controller.validateBirthCity(false);
                                    if (qtdLetters > 2 &&
                                        !_controller.loading) {
                                      return Container(
                                        color: AppColors.error,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.only(
                                              left: 20.0,
                                              top: 5.0,
                                              bottom: 5.0),
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
                                            padding:
                                                EdgeInsets.only(bottom: 20.0),
                                            color: AppColors.white,
                                            iconSize: 15.0,
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              _controller
                                                  .validateBirthCity(false);
                                              _controller.birthCityController
                                                  .text = "";
                                              _controller.profile.birth.place
                                                  .city = "";
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
                                        color: _controller.cities
                                                        .indexOf(suggestion) %
                                                    2 ==
                                                0
                                            ? AppColors.support3
                                            : AppColors.white,
                                        child: ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 10.0),
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
                                    _controller.validateBirthCity(true);
                                    _controller.birthCityController.text =
                                        suggestion;
                                    _controller.profile.birth.place.city =
                                        suggestion;
                                  },
                                  onSaved: (value) {
                                    _controller.validateBirthCity(true);
                                    _controller.profile.birth.place.city =
                                        value;
                                    _controller.birthCityController.text =
                                        value;
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(22, 32, 22, 35),
                        margin: EdgeInsets.only(bottom: 10),
                        color: AppColors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 5),
                            child: _bindText('Adicione seus interesses', 16,
                                AppColors.mainFontOpacity9, TextAlign.left),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.mainBorderOpacity7),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      _controller.profile.interestedIn != null
                                          ? _controller.profile.interestedIn
                                                          .length >=
                                                      0 &&
                                                  _controller
                                                          .profile
                                                          .interestedIn
                                                          .length <=
                                                      2
                                              ? 40
                                              : _controller.profile.interestedIn
                                                              .length >
                                                          2 &&
                                                      _controller
                                                              .profile
                                                              .interestedIn
                                                              .length <
                                                          5
                                                  ? 80
                                                  : 120
                                          : 0,
                                  color: AppColors.white,
                                  child: Material(
                                      color: AppColors.white,
                                      child: AlwaysVisibleScrollbar.grid(
                                          crossAxisCount: 2,
                                          padding: EdgeInsets.only(right: 5),
                                          scrollDirection: Axis.vertical,
                                          scrollbarColor: AppColors.dialogBox,
                                          childAspectRatio: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          children: map<Widget>(
                                              _controller.profile.interestedIn,
                                              (index, id) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.dialogBox,
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.formBorder),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Expanded(
                                                        child: Text(
                                                      _controller
                                                          .textWithFirstLetterUppercase(
                                                              _controller
                                                                  .interests
                                                                  .where((interest) =>
                                                                      interest
                                                                          .id ==
                                                                      id)
                                                                  .first
                                                                  .label),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Nunito',
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: AppColors
                                                              .secondFont),
                                                    )),
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    child: IconButton(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      icon: Image.asset(
                                                          'assets/images/close.png'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _controller.profile
                                                              .interestedIn
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }))),
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result =
                                            await AppUtils.defaultDialogProfile(
                                                context,
                                                'interests',
                                                _controller.interests,
                                                _controller
                                                    .profile.interestedIn);
                                        setState(() {
                                          _controller.profile.interestedIn =
                                              result;
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/plus-circle-filled-icon.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ])),
                    Container(
                        padding: EdgeInsets.fromLTRB(22, 32, 22, 35),
                        color: AppColors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 5),
                            child: _bindText('Formas de amar', 16,
                                AppColors.mainFontOpacity9, TextAlign.left),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.mainBorderOpacity7),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: _controller.profile.waysOfLove
                                          .map((text) => Container(
                                                height: 52,
                                                padding: EdgeInsets.all(13),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: AppColors
                                                            .mainBorderOpacity7,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: _bindText(
                                                          _controller.textWithFirstLetterUppercase(
                                                              _controller
                                                                  .waysOfLove
                                                                  .where((interest) =>
                                                                      interest
                                                                          .id ==
                                                                      text)
                                                                  .first
                                                                  .title),
                                                          14,
                                                          AppColors
                                                              .mainFontOpacity9,
                                                          TextAlign.left),
                                                    ),
                                                    Container(
                                                        width: 25,
                                                        child: Material(
                                                          color:
                                                              AppColors.white,
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            icon: Image.asset(
                                                                'assets/images/plus-circle-filled-icon-grey.png'),
                                                            onPressed: () {
                                                              setState(() {
                                                                _controller
                                                                    .profile
                                                                    .waysOfLove
                                                                    .remove(
                                                                        text);
                                                              });
                                                            },
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final result =
                                          await AppUtils.defaultDialogProfile(
                                              context,
                                              'waysOfLove',
                                              _controller.waysOfLove,
                                              _controller.profile.waysOfLove);
                                      setState(() {
                                        _controller.profile.waysOfLove = result;
                                      });
                                    },
                                    child: Container(
                                      height: 52,
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                          gradient: AppColors.waysLoveGradient,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: _bindText(
                                                'ADICIONAR FORMA DE AMAR',
                                                11,
                                                AppColors.white,
                                                TextAlign.left),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Image.asset(
                                              'assets/images/plus-circle-filled-icon-white.png',
                                              width: 18,
                                              height: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ]))
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 22.0, top: 22.0),
                    child: GestureDetector(
                      onTap: () {
                        Modular.to.pop();
                      },
                      child: Image.asset(
                        'assets/images/voltar.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    ),
                  )
                ],
              ),
            );
          }
        },
      )),
    );
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  _getAllItem() {
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) => print(a.title));
  }

  _bindText(String text, double size, Color color, TextAlign align) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w400,
          fontFamily: 'Nunito',
          decoration: TextDecoration.none,
          color: color),
    );
  }

  int _getNumberOfLines() {
    final height = MediaQuery.of(context).size.height * 0.5419;
    final cellHeight = MediaQuery.of(context).size.height * 0.0903;
    return height ~/ cellHeight;
  }

  circularProgressIndicator() {
    if (_controller.loading) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }
}
