import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

import 'package:joinder_app/app/shared/widgets/range_slider.dart' as frs;

import '../profile_controller.dart';

class ConfigFiltersPage extends StatefulWidget {
  @override
  _ConfigFiltersPageState createState() => _ConfigFiltersPageState();
}

class _ConfigFiltersPageState extends State<ConfigFiltersPage> {
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<ProfileController>();
    _controller.getUserProfile(false);
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
            actions: <Widget>[
              Observer(
                builder: (_) {
                  if (_controller.profile.configuration != null) {
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
                        _controller
                              .saveConfigurationProfile(context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
          body: Observer(builder: (_) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/config_filters.png',
                                    height: 24.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 9.0, right: 22, left: 22.0),
                              child: Text(
                                "Selecione a faixa de idade",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.mainFont,
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: 45.0, right: 10.0, left: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SliderTheme(
                                      data: SliderThemeData(
                                        thumbColor: AppColors.backgroundSlider,
                                        activeTrackColor:
                                            AppColors.backgroundSlider,
                                        inactiveTrackColor: Colors.grey,
                                        valueIndicatorColor:
                                            AppColors.backgroundSlider,
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                      ),
                                      child: frs.RangeSlider(
                                        min: 18.0,
                                        max: 50.0,
                                        lowerValue: _controller.profile.configuration.age.min,
                                        upperValue: _controller.profile.configuration.age.max,
                                        showValueIndicator: true,
                                        valueIndicatorFormatter:
                                            (int index, double value) {
                                          String valueData =
                                              value.toStringAsFixed(0);
                                          return '$valueData anos';
                                        },
                                        valueIndicatorMaxDecimals: 0,
                                        onChanged: (double newLowerValue,
                                            double newUpperValue) {
                                          setState(() {
                                            _controller.profile.configuration.age.min = newLowerValue;
                                            _controller.profile.configuration.age.max = newUpperValue;
                                          });
                                        },
                                      ),
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 22, left: 22.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "${_controller.profile.configuration.age.min.toStringAsFixed(0)}${_controller.profile.configuration.age.min.toStringAsFixed(0) == '50' ? '+' : ''}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: AppColors.mainFont,
                                                fontSize: 12.0,
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 22, left: 22.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "${_controller.profile.configuration.age.max.toStringAsFixed(0)}${_controller.profile.configuration.age.max.toStringAsFixed(0) == '50' ? '+' : ''}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: AppColors.mainFont,
                                                fontSize: 12.0,
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 60.0, right: 60.0, top: 35.0),
                              color: AppColors.formBorder,
                              height: 1.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 28.0, right: 22, left: 22.0),
                              child: Text(
                                "Selecione a distância máxima",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.mainFont,
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0),
                              ),
                            ),
                            Container(
                                padding: EdgeInsetsDirectional.only(top: 45.0),
                                child: Column(
                                  children: <Widget>[
                                    SliderTheme(
                                        data: SliderThemeData(
                                          thumbColor:
                                              AppColors.backgroundSlider,
                                          activeTrackColor:
                                              AppColors.backgroundSlider,
                                          inactiveTrackColor: Colors.grey,
                                          valueIndicatorColor:
                                              AppColors.backgroundSlider,
                                          showValueIndicator:
                                              ShowValueIndicator.always,
                                          valueIndicatorShape:
                                              PaddleSliderValueIndicatorShape(),
                                          thumbShape: RoundSliderThumbShape(),
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          tickMarkShape:
                                              RoundSliderTickMarkShape(),
                                          valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Slider(
                                          onChanged: (value) {
                                            setState(() {
                                              _controller.profile.configuration.distance.max = value;
                                            });
                                          },
                                          label:
                                              '${_controller.profile.configuration.distance.max.toStringAsFixed(0)} KM',
                                          min: 1.0,
                                          max: 50.0,
                                          value: _controller.profile.configuration.distance.max,
                                        )),
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 22, left: 22.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "1 KM",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: AppColors.mainFont,
                                                fontSize: 12.0,
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 22, left: 22.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "50 KM",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: AppColors.mainFont,
                                                fontSize: 12.0,
                                                fontFamily: 'Nunito'),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
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
          }),
        ),
      ),
    );
  }
}
