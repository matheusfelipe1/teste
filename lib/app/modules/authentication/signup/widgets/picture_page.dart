import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';

import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            JihTip(
              imagePath: "assets/images/jih1.png",
              text:
                  "E aí? Gostou da sua foto?\nÉ só clicar em gostei, ou\nvocê pode trocá-la.",
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Observer(
                builder: (_) {
                  if (!_controller.hasUploadError && (_controller.currentPicture != "" ||
                      (_controller.profile.photos != null &&
                          _controller.profile.photos.length > 0))) {
                    return CachedNetworkImage(
                        imageUrl: _controller.currentPicture != ""
                            ? _controller.currentPicture
                            : _controller.profile.photos.first,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: MediaQuery.of(context).size.height * 0.15,
                            ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.purple)),
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
                              Container(
                                width: 180,
                                padding: EdgeInsets.only(
                                    top: 10.0, left: 15.0, right: 15.0),
                                child: CustomOutlineButton(
                                  text: "TENTAR NOVAMENTE",
                                  onPressed: () {
                                    _controller.setPage(3);
                                  },
                                ),
                              )
                            ],
                          );
                        });
                  } else if (_controller.hasUploadError) {
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
                            _controller.uploadErrorMessage,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Nunito',
                                fontSize: 14.0),
                          ),
                        ),
                        Container(
                          width: 180,
                          padding: EdgeInsets.only(
                              top: 10.0, left: 15.0, right: 15.0),
                          child: CustomOutlineButton(
                            text: "TENTAR NOVAMENTE",
                            onPressed: () {
                              _controller.setPage(3);
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    );
                  }
                },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 24.0, right: 12.0),
                        child: CustomOutlineButton(
                          text: "TROCAR",
                          onPressed: () {
                            _controller.setPage(3);
                          },
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 12.0,
                                right: 24.0),
                            child: PrimaryButton(
                              text: "GOSTEI",
                              onPressed: (_controller.currentPicture != "" ||
                                      (_controller.profile.photos != null &&
                                          _controller.profile.photos.length >
                                              0))
                                  ? () {
                                      setState(() {
                                        _controller.isButtonDisabled = true;
                                      });
                                      _controller.profile.photos =
                                          new List<String>();
                                      _controller.profile.photos
                                          .add(_controller.currentPicture);
                                      _controller.setPage(4);
                                    }
                                  : null,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
