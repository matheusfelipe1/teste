import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:joinder_app/app/modules/authentication/phone_auth/phone_auth_controller.dart';

import 'package:joinder_app/app/shared/widgets/primary_button.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class PhoneInputPage extends StatefulWidget {
  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  PhoneAuthController _controller;
  TextEditingController _codeController;
  TextEditingController _phoneController;
  List<MaskTextInputFormatter> _masks = new List<MaskTextInputFormatter>();

  @override
  void initState() {
    _controller = Modular.get<PhoneAuthController>();
    _codeController = new TextEditingController();
    _phoneController = new TextEditingController();
    _masks.add(new MaskTextInputFormatter(mask: '(##) #####-####'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColors.support2))),
                      child: TextField(
                        controller: _codeController,
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
                                bottom: BorderSide(color: AppColors.support2))),
                        child: Observer(
                          builder: (_) {
                            return TextFormField(
                              controller: _phoneController,
                              autocorrect: false,
                              autovalidate: true,
                              obscureText: false,
                              inputFormatters: _masks,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => _controller.setPhone(value),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: AppColors.mainFont,
                                    fontSize: 14.0,
                                    fontFamily: 'Nunito'),
                                hintText: 'N??mero de telefone',
                                fillColor: AppColors.support2,
                                enabled: false,
                              ),
                            );
                          },
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'Quando voc?? clicar em pr??ximo, o joinder.me enviar?? uma mensagem de texto com o c??digo de verifica????o. Tarifas de mensagens e dados podem ser aplic??veis. O n??mero de telefone confirmado pode ser utilizado para entrar no joinder.me. ',
                          style: TextStyle(
                              color: AppColors.secondFont,
                              fontSize: 12.0,
                              fontFamily: 'Nunito')),
                      // TextSpan(
                      //     text:
                      //         'Saiba o que acontece se seu n??mero de telefone mudar',
                      //     style: TextStyle(
                      //         decoration: TextDecoration.underline,
                      //         color: AppColors.fontLink,
                      //         fontSize: 12.0,
                      //         fontFamily: 'Nunito')),
                    ]),
                  ),
                )
              ],
            ),
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
                child: PrimaryButton(
                  text: "PR??XIMO",
                  onPressed: () async {
                    _controller.submitPhone(context);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
