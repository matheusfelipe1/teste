import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';
import 'package:joinder_app/app/modules/chat/chat_detail/media_page.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

// typeUsers: 0 = ME; 1 = ANOTHER; 2 = robo

String typeButton = '';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  ChatController _controller;
  AuthController _authController;
  TextEditingController _msgController;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _controller = Modular.get<ChatController>();
    _authController = Modular.get<AuthController>();
    typeButton = 'assets/images/btn_submit_chat_disable.png';
    _msgController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height,
                      color: AppColors.backgroundChat,
                      padding: EdgeInsets.only(
                          top: 90,
                          bottom: 75 + MediaQuery.of(context).padding.bottom),
                      child: Observer(
                        builder: (_) {
                          if (!_controller.isLoading) {
                            scrollDown();
                            return ListView.builder(
                                controller: _scrollController,
                                reverse: false,
                                padding: const EdgeInsets.all(8),
                                itemCount:
                                    _controller.selectedChat.messages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      _controller.selectedChat.messages[index];
                                  final DateFormat formatter =
                                      DateFormat('HH:mm');
                                  DateTime date =
                                      DateTime.parse(item.date + 'Z');
                                  DateTime dateLocal = date.toLocal();

                                  return _bindTalk(
                                    item.type == "jih"
                                        ? 3
                                        : item.sender ==
                                                _authController.profile.id
                                            ? 0
                                            : 1,
                                    item.type,
                                    item.sender,
                                    item.type == 'jih'
                                        ? 'assets/images/jih_psicologa.png'
                                        : item.sender ==
                                                _authController.profile.id
                                            ? _authController
                                                        .profile.photos.length >
                                                    0
                                                ? _authController
                                                    .profile.photos.first
                                                : AppUtils.getSignImage(
                                                    _authController.profile)
                                            : _controller.selectedChat.profile
                                                .photos.first,
                                    item.value,
                                    formatter.format(
                                        DateTime.parse(dateLocal.toString())
                                            .toLocal()),
                                  );
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                  Positioned(
                    top: 90,
                    child: Observer(
                      builder: (_) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                          width: MediaQuery.of(context).size.width,
                          height: _controller.isUploading ? 60.0 : 0.0,
                          padding: EdgeInsets.all(20.0),
                          color: AppColors.purple,
                          child: _controller.isUploading
                              ? Row(
                                  children: <Widget>[
                                    SizedBox(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              AppColors.white)),
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        "Carregando Imagem...",
                                        style:
                                            TextStyle(color: AppColors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 90,
                    child: Observer(
                      builder: (_) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                          width: MediaQuery.of(context).size.width,
                          height: _controller.hasUploadError ? 60.0 : 0.0,
                          padding: EdgeInsets.all(20.0),
                          color: AppColors.backgroundRed,
                          child: _controller.hasUploadError
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _controller.uploadErrorMessage,
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller.hasUploadError = false;
                                        _controller.uploadErrorMessage = "";
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                child: IconButton(
                                    onPressed: () {
                                      Modular.to.pop();
                                    },
                                    icon: Image.asset(
                                      'assets/images/back_purple_chat.png',
                                      width: 30,
                                    ))),
                            Container(
                                padding: EdgeInsets.only(right: 15),
                                child: Observer(
                                  builder: (_) {
                                    if (!_controller.isLoading) {
                                      return SingleChildScrollView(
                                        child: GestureDetector(
                                          onTap: () {
                                            Modular.to.pop();
                                            _controller.redirectProfileDetail(
                                                _controller
                                                    .selectedChat.profile);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                  imageUrl: _controller
                                                              .selectedChat
                                                              .profile
                                                              .photos
                                                              .length >
                                                          0
                                                      ? _controller.selectedChat
                                                          .profile.photos.first
                                                      : AppUtils.getSignImage(
                                                          _controller
                                                              .selectedChat
                                                              .profile),
                                                  fit: BoxFit.cover,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    500.0),
                                                        child: Image(
                                                          image: imageProvider,
                                                          width: 57.0,
                                                          height: 57.0,
                                                          fit: BoxFit.cover,
                                                        ),
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
                                                      ],
                                                    );
                                                  }),
                                              Text(
                                                _controller
                                                    .selectedChat.profile.name,
                                                style: TextStyle(
                                                    height: 1.5,
                                                    color: AppColors.mainFont,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                )),
                            Container(
                              padding: EdgeInsets.only(top: 15, right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  final result =
                                      await AppUtils.wantToDoDialog(context);
                                  if (result != null) {
                                    if (result['option'] == 1) {
                                      _controller.addToFridge(
                                          context, result['desc']);
                                    } else if (result['option'] == 2) {
                                      _controller.reportUser(
                                          context, result['desc']);
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/more.png',
                                  width: 27,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom + 15,
                            top: 15.0,
                            left: 10.0,
                            right: 10.0),
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  _controller.uploadPhoto(ImageSource.camera);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 7),
                                  child: Image.asset('assets/images/camera.png',
                                      width: 18),
                                )),
                            GestureDetector(
                                onTap: () {
                                  _controller.uploadPhoto(ImageSource.gallery);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 7),
                                  child: Image.asset(
                                      'assets/images/gallery-chat.png',
                                      width: 18),
                                )),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(right: 7),
                                  child: Image.asset(
                                      'assets/images/figurines.png',
                                      width: 20),
                                )),
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Material(
                                  color: AppColors.white,
                                  child: TextFormField(
                                    controller: _msgController,
                                    autocorrect: false,
                                    autovalidate: true,
                                    keyboardType: TextInputType.text,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        hintStyle: TextStyle(
                                            color: AppColors.formHint,
                                            fontSize: 14.0,
                                            fontFamily: 'Nunito'),
                                        hintText: "Digite sua mensagem...",
                                        filled: true,
                                        fillColor: AppColors.formBackground,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: AppColors.formBorder,
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.formBorder,
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.formBorder,
                                                width: 2.0,
                                                style: BorderStyle.solid))),
                                    cursorColor: AppColors.firstFont,
                                    maxLines: 1,
                                    onChanged: (text) {
                                      setState(() {
                                        var textoSemEspaco =
                                            _msgController.text.trim();
                                        if (_msgController.text == "" ||
                                            _msgController.text == null ||
                                            textoSemEspaco == '') {
                                          typeButton =
                                              'assets/images/btn_submit_chat_disable.png';
                                        } else {
                                          typeButton =
                                              'assets/images/btn_submit_chat_enable.png';
                                        }
                                      });
                                    },
                                    style: TextStyle(
                                        color: AppColors.mainFont,
                                        fontSize: 14.0,
                                        fontFamily: 'Nunito'),
                                  )),
                            )),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  var textoSemEspaco =
                                      _msgController.text.trim();
                                  if (_msgController.text != "" &&
                                      _msgController.text != null &&
                                      textoSemEspaco != '') {
                                    _controller
                                        .addMessageToChat(_msgController.text);
                                    _msgController.text = '';
                                    scrollDown();
                                  }
                                });
                              },
                              child: Image.asset(
                                typeButton,
                                width: 33,
                              ),
                            )
                          ],
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }

  scrollDown() {
    Timer(Duration(milliseconds: 500), () {
      return {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent)
      };
    });
  }

  _bindTalk(int typeUser, String typeMessage, String sender, String photo,
      String msg, String hour) {
    return typeUser == 0
        ? _bindTalkMe(photo, typeMessage, msg, hour)
        : typeUser == 1
            ? _bindTalkAnother(photo, typeMessage, msg, hour)
            : _bindTalkRobo(sender, photo, msg, hour);
  }

  _bindTalkAnother(String photo, String type, String msg, String hour) {
    switch (type) {
      case 'image':
        return Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          margin: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CachedNetworkImage(
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(500.0),
                          child: Image(
                            image: imageProvider,
                            width: 45.0,
                            height: 45.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    errorWidget: (context, url, error) {
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                width: 200,
                height: 225,
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaPage(image: msg),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.formBorder),
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.white),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CachedNetworkImage(
                            imageUrl: msg,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  width: 200.0,
                                  height: 180.0,
                                  fit: BoxFit.cover,
                                ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.white)),
                            errorWidget: (context, url, error) {
                              return Column(
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6 - 20,
                      padding: EdgeInsets.only(top: 7),
                      child: Text(hour,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: AppColors.thirthFont,
                              fontFamily: 'Nunito')),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CachedNetworkImage(
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(500.0),
                          child: Image(
                            image: imageProvider,
                            width: 45.0,
                            height: 45.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    errorWidget: (context, url, error) {
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                width: calcularTamanhoTalk(msg),
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.formBorder),
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.white),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      child: Text(
                        msg,
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.mainFont,
                            fontFamily: 'Nunito',
                            fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(hour,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: AppColors.thirthFont,
                              fontFamily: 'Nunito')),
                    )
                  ],
                ),
              )
            ],
          ),
        );
    }
  }

  _bindTalkMe(String photo, String type, String msg, String hour) {
    switch (type) {
      case 'image':
        return Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          margin: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 200,
                height: 220,
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaPage(image: msg),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: AppColors.chatGradient),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CachedNetworkImage(
                            imageUrl: msg,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  width: 200.0,
                                  height: 180.0,
                                  fit: BoxFit.cover,
                                ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.white)),
                            errorWidget: (context, url, error) {
                              return Column(
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6 - 20,
                      padding: EdgeInsets.only(top: 7),
                      child: Text(hour,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: AppColors.thirthFont,
                              fontFamily: 'Nunito')),
                    )
                  ],
                ),
              ),
              Container(
                child: CachedNetworkImage(
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(500.0),
                          child: Image(
                            image: imageProvider,
                            width: 45.0,
                            height: 45.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    errorWidget: (context, url, error) {
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          margin: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: calcularTamanhoTalk(msg),
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: AppColors.chatGradient),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      child: Text(
                        msg,
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Nunito',
                            fontSize: 14.0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6 - 20,
                      padding: EdgeInsets.only(top: 7),
                      child: Text(hour,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: AppColors.thirthFont,
                              fontFamily: 'Nunito')),
                    )
                  ],
                ),
              ),
              Container(
                child: CachedNetworkImage(
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(500.0),
                          child: Image(
                            image: imageProvider,
                            width: 45.0,
                            height: 45.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.purple)),
                    errorWidget: (context, url, error) {
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        );
    }
  }

  _bindTalkRobo(String sender, String photo, String msg, String hour) {
    if (_authController.profile.id == sender) {
      return Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        margin: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: calcularTamanhoTalk(msg),
              padding: EdgeInsets.only(right: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: AppColors.jihGradient),
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Text(
                  msg,
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'Nunito',
                      fontSize: 14.0),
                ),
              ),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset(
                  photo,
                  width: 45,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  calcularTamanhoTalk(String msg) {
    double tamanhoMaximoTela = MediaQuery.of(context).size.width * 0.6;
    // Quantidade de caracteres * tamanho da letra + padding lateral
    double widthMsg = ((msg.length * 14).toDouble() + 40);
    double widthTalk =
        widthMsg > tamanhoMaximoTela ? tamanhoMaximoTela : widthMsg;
    return widthTalk;
  }
}
