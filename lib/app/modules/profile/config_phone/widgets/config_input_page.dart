import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:joinder_app/app/modules/profile/config_phone/config_phone_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class ConfigInputPage extends StatefulWidget {
  @override
  _ConfigInputPageState createState() => _ConfigInputPageState();
}

class _ConfigInputPageState extends State<ConfigInputPage> {
  ConfigPhoneController _controller;
  TextEditingController _dddController;
  TextEditingController _phoneController;
  List<MaskTextInputFormatter> _masks = new List<MaskTextInputFormatter>();

  @override
  void initState() {
    _controller = Modular.get<ConfigPhoneController>();
    _dddController = new TextEditingController();
    _phoneController = new TextEditingController();
    _masks.add(new MaskTextInputFormatter(mask: '(##) #####-####'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        top: 29.0, bottom: 21.0, right: 22, left: 22.0),
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
                  Container(
                    color: AppColors.formBorder,
                    height: 1.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 19.0, right: 22, left: 22.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/cellphone.png',
                          height: 24.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 22),
                              child: Text(
                                "NÚMERO DO TELEFONE",
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
                                "55 31 99126-7898",
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
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: AppColors.support2))),
                          child: TextField(
                            controller: _dddController,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: AppColors.mainFont,
                                  fontSize: 14.0,
                                  fontFamily: 'Nunito'),
                              hintText: 'BR + 55',
                              enabled: false,
                              fillColor: AppColors.purple,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: AppColors.support2))),
                          child: TextFormField(
                            controller: _phoneController,
                            autocorrect: false,
                            autovalidate: true,
                            obscureText: false,
                            inputFormatters: _masks,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: AppColors.mainFont,
                                  fontSize: 14.0,
                                  fontFamily: 'Nunito'),
                              hintText: 'Número de telefone ',
                              fillColor: AppColors.support2,
                              enabled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
