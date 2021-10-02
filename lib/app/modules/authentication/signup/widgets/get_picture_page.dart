import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

class GetPicturePage extends StatefulWidget {
  @override
  _GetPicturePageState createState() => _GetPicturePageState();
}

class _GetPicturePageState extends State<GetPicturePage> {
  SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    _controller.currentPicture = "";
    _controller.hasUploadError = false;
    _controller.uploadErrorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                JihTip(
                  imagePath: "assets/images/jih2.png",
                  text:
                      "Você pode tirar uma\nfoto agora mesmo\nou escolher alguma\ndo seu celular.\nTamanho máximo\n1 MB.",
                ),
                Container(
                  decoration: _allBoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _controller.pickImage(ImageSource.camera);
                        },
                        child: Container(
                          decoration: _verticalBoxDecoration(),
                          padding: EdgeInsets.only(top: 35.0, bottom: 35.0),
                          width: (MediaQuery.of(context).size.width / 2) - 1.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset('assets/images/camera.png',
                                  height: 35),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'TIRAR FOTO\nAGORA',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.secondFont,
                                    fontSize: 11.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: (MediaQuery.of(context).size.width / 2) - 1.0,
                          child: Column(
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/gallery.png',
                                height: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'SELECIONAR\nDA GALERIA',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondFont,
                                    fontSize: 11.0,
                                    fontFamily: 'Nunito',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'Ah, no joinder.me isso não é o que\n mais te representa ;) ',
                          style: TextStyle(
                              color: AppColors.thirthFont,
                              fontSize: 14.0,
                              fontFamily: 'Nunito')),
                      TextSpan(
                          text: 'Be Free!',
                          style: TextStyle(
                              color: AppColors.fourthFont,
                              fontSize: 14.0,
                              fontFamily: 'Nunito')),
                    ]),
                  ),
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
                // Container(
                //   width: 155,
                //   padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                //   child: PrimaryButton(
                //     text: 'PRÓXIMO',
                //     onPressed: () {

                //     },
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 24.0, right: 12.0),
                  child: CustomOutlineButton(
                    text: "PULAR",
                    onPressed: () {
                      _controller.profile.photos = new List<String>();
                      setState(() {
                        _controller.isButtonDisabled = true;
                      });
                      _controller.setPage(4);
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 12.0, right: 24.0),
                  child: PrimaryButton(
                    text: "PRÓXIMO",
                    onPressed: () {
                      _controller.profile.photos = new List<String>();
                      setState(() {
                        _controller.isButtonDisabled = true;
                      });
                      _controller.setPage(4);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ],
    ));
  }
}

BoxDecoration _allBoxDecoration() {
  return BoxDecoration(
    color: Color.fromRGBO(247, 244, 248, 1),
    border: Border.all(
      color: AppColors.mainBorder,
      style: BorderStyle.solid,
      width: 1.0,
    ),
  );
}

BoxDecoration _verticalBoxDecoration() {
  return BoxDecoration(
      border: Border(
          right: BorderSide(
              color: AppColors.mainBorder,
              width: 1.0,
              style: BorderStyle.solid)));
}
