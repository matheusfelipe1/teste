import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class FridgePage extends StatefulWidget {
  @override
  _FridgePageState createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  ChatController _controller;

  @override
  void initState() {
    _controller = Modular.get<ChatController>();
    _controller.getFridgeChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Image.asset(
                  'assets/images/back_white.png',
                  width: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Geladeira',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nunito',
                        decoration: TextDecoration.none,
                        color: AppColors.white),
                  ),
                  _showRemoveButton()
                ],
              ),
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(gradient: AppColors.colorBackgroundFridge),
              ),
            ),
            body: Observer(
              builder: (_) {
                if (!_controller.isLoading) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: _controller.fridge.length > 0
                        ? Padding(
                            padding:
                                EdgeInsets.only(right: 8, top: 5, bottom: 5),
                            child: AlwaysVisibleScrollbar.grid(
                                crossAxisCount: 1,
                                padding: EdgeInsets.only(right: 10),
                                scrollDirection: Axis.vertical,
                                childAspectRatio: 4.5,
                                scrollbarColor: AppColors.formBorder,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                children: map<Widget>(
                                  _controller.fridge,
                                  (index, url) {
                                    return GestureDetector(
                                      onTap: () {
                                        _verifyShowButtonRemove(index);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: AppColors
                                                          .formBorder))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              _bindButton(index),
                                              Flexible(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 45,
                                                    width: 45,
                                                    child: CachedNetworkImage(
                                                        imageUrl: _controller
                                                                    .fridge[
                                                                        index]
                                                                    .photos
                                                                    .length >
                                                                0
                                                            ? _controller
                                                                .fridge[index]
                                                                .photos
                                                                .first
                                                            : AppUtils.getSignImageCard(_controller
                                                                .fridge[index]
                                                                .sign.sunSign),
                                                        fit: BoxFit.cover,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          500.0),
                                                              child: Image(
                                                                image:
                                                                    imageProvider,
                                                                width: 45.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                        placeholder: (context, url) =>
                                                            CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation(
                                                                    AppColors
                                                                        .purple)),
                                                        errorWidget:
                                                            (context, url, error) {
                                                          return Column(
                                                            children: <Widget>[
                                                              Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        })),
                                              ),
                                              Flexible(
                                                  child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  _controller
                                                      .fridge[index].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .mainFontOpacity9,
                                                    fontSize: 14.0,
                                                    fontStyle: FontStyle.normal,
                                                    fontFamily: 'Nunito',
                                                  ),
                                                ),
                                              )),
                                            ],
                                          )),
                                    );
                                  },
                                )),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/ice.png',
                                  width: 60,
                                ),
                                Text(
                                  'NENHUM GELO À \n VISTAAA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.mainFontOpacity9,
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3),
                                  child: Text(
                                    'Você não deu gelo em ninguém.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      height: 2,
                                      color: AppColors.thirthFont,
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                )
                              ],
                            )),
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
      ),
    );
  }

  Widget _bindButton(index) {
    if (_controller.fridgeMarks[index]['marked'])
      return Container(
        width: 23,
        height: 23,
        margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            gradient: AppColors.checkGradient,
            border: Border.all(
                color: AppColors.mainBorder,
                width: 2.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
        child: Center(
          child: Image.asset(
            'assets/images/checked.png',
            height: 8,
          ),
        ),
      );
    else
      return Container(
        width: 23,
        height: 23,
        margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: AppColors.support3,
            border: Border.all(
                color: AppColors.mainBorder,
                width: 2.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(4.0)),
      );
  }

  _verifyShowButtonRemove(int index) {
    setState(() {
      _controller.fridgeMarks[index]['marked'] =
          !_controller.fridgeMarks[index]['marked'];
    });
  }

  _showRemoveButton() {
    if (_controller.fridgeMarks != null &&
        _controller.fridgeMarks.where((f) => f['marked']).length > 0 &&
        _controller.fridge.length > 0) {
      return FlatButton(
        onPressed: () {
          _controller.deleteFridgeChats();
        },
        padding: EdgeInsets.all(0.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'REMOVER',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11.0,
              fontStyle: FontStyle.normal,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
