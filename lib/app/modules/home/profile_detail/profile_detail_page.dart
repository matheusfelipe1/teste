import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:icon_shadow/icon_shadow.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';
import 'package:joinder_app/app/shared/widgets/custom_carousel_photos/custom_carousel_photos.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/modules/home/home_controller.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

Color color_icon_back = AppColors.white;

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  ScrollController _scrollController;
  HomeController _controller;
  ChatController _chatController;
  _scrollListener() {
    if (_scrollController.position.pixels >
        MediaQuery.of(context).size.height * 0.43) {
      setState(() {
        color_icon_back = AppColors.purple;
      });
    } else {
      setState(() {
        color_icon_back = AppColors.white;
      });
    }
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    _controller = Modular.get<HomeController>();
    _chatController = Modular.get<ChatController>();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          // margin:
          //     EdgeInsets.only(top: MediaQuery.of(context).padding.top * 2 + 55),
          margin: EdgeInsets.only(top: 15.0),
          child: IconShadowWidget(
            Icon(Icons.arrow_back, color: color_icon_back, size: 28),
            shadowColor: Colors.black54,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        color: AppColors.purple,
        child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
                  color: AppColors.formBackground,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            color: AppColors.white,
                            child: Column(
                              children: <Widget>[
                                CustomCarouselPhotos(
                                  photos:
                                      _controller.cardDetail.photos.length > 0
                                          ? _controller.cardDetail.photos
                                          : [
                                              AppUtils.getSignImageCard(
                                                  _controller.cardDetail.sign)
                                            ],
                                  name: _controller.cardDetail.name,
                                  age: "${_controller.cardDetail.age}",
                                  profile: _controller.cardDetail,
                                ),
                                Container(
                                  child: Image.asset(
                                    AppUtils.getSignIcon(AppUtils.getSignCard(
                                        _controller.cardDetail.sign)),
                                    height: 110.0,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    AppUtils.getSignCard(
                                        _controller.cardDetail.sign),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 0.8,
                                        fontSize: 40.0,
                                        fontFamily: 'Shink',
                                        color: AppColors.getSignColor(
                                            AppUtils.getSignCard(
                                                _controller.cardDetail.sign)),
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: EdgeInsets.only(right: 14),
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: AppColors
                                                  .dividerBorderVertical),
                                        )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${_controller.cardDetail.city} | ${_controller.cardDetail.state}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                fontFamily: 'Nunito',
                                                decoration: TextDecoration.none,
                                                color:
                                                    AppColors.mainFontOpacity9,
                                              ),
                                            ),
                                            Text(
                                              '${_controller.cardDetail.distance} KM DE DISTÂNCIA',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: 'Nunito',
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: AppColors.mainFont),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: EdgeInsets.only(left: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${_controller.cardDetail.percent}%',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  height: 0.8,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'Nunito',
                                                  color: AppColors.mainFont),
                                            ),
                                            Text(
                                              'COMPATÍVEL',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  height: 1.3,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Nunito',
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: AppColors
                                                      .mainFontOpacity9),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            AppColors.white,
                                            AppColors.formBackground,
                                            AppColors.formBackground,
                                            AppColors.formBackground,
                                            AppColors.white
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.33,
                                            0.38,
                                            0.43,
                                            0.48,
                                            0.53
                                          ])),
                                  child: Center(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.mainBorder,
                                            width: 1.0,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          if (!_controller.isButtonDisabled) {
                                            _controller.isButtonDisabled = true;
                                            Modular.to.pop();
                                            _chatController.createChat(
                                                _controller.cardDetail.id);
                                          } else {
                                            null;
                                          }
                                        },
                                        backgroundColor:
                                            AppColors.formBackground,
                                        elevation: 4,
                                        child: Image.asset(
                                          'assets/images/chat_floating.png',
                                          width: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.fromLTRB(23, 0, 23, 20),
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'O que busco',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Nunito',
                                        decoration: TextDecoration.none,
                                        color: AppColors.mainFont),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: map<Widget>(
                                          _controller.cardDetail.goals,
                                          (index, id) {
                                        return _bindGoals(id, _controller);
                                      })),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.fromLTRB(23, 35, 23, 28),
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Sobre',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Nunito',
                                        decoration: TextDecoration.none,
                                        color: AppColors.mainFont),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    _controller.cardDetail.content,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Nunito',
                                        decoration: TextDecoration.none,
                                        color: AppColors.fontGrayLight),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.fromLTRB(23, 35, 23, 10),
                              color: AppColors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Interesses',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          decoration: TextDecoration.none,
                                          color: AppColors.mainFont),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 15),
                                    height: 150,
                                    child: AlwaysVisibleScrollbar.grid(
                                        crossAxisCount: 3,
                                        padding: EdgeInsets.only(right: 10),
                                        scrollDirection: Axis.vertical,
                                        childAspectRatio: 2,
                                        scrollbarColor: AppColors.formBorder,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        children: map<Widget>(
                                            _controller.cardDetail.interestedIn,
                                            (index, id) {
                                          return _bindText(id, _controller);
                                        })),
                                  )
                                ],
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.fromLTRB(23, 35, 23, 14),
                              color: AppColors.white,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'Formas de amar',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Nunito',
                                            decoration: TextDecoration.none,
                                            color: AppColors.mainFont),
                                      ),
                                    ),
                                    Column(
                                      children: map<Widget>(
                                          _controller.cardDetail.waysOfLove,
                                          (index, id) {
                                        return _bindWaysOfLove(
                                            id, _controller, context);
                                      }),
                                    )
                                  ])),
                        ],
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}

Widget _bindWaysOfLove(id, controller, context) {
  return Container(
      margin: EdgeInsets.only(top: 6.45),
      padding: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
              color: AppColors.selectedBorder,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 15.0, left: 15.0, right: 15.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                      bottom: BorderSide(color: AppColors.selectedBorder))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppUtils.textWithFirstLetterUppercase(controller.waysOfLove
                        .where((interest) => interest.id == id)
                        .first
                        .title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainFontOpacity9,
                        fontFamily: "Nunito",
                        fontSize: 12.0),
                  ),
                  Image.asset(
                    AppUtils.getIconsToWayOfLove(id, 'cinza'),
                    width: 30.0,
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              controller.waysOfLove
                  .where((interest) => interest.id == id)
                  .first
                  .description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  color: AppColors.mainFontOpacity9,
                  fontFamily: "Nunito",
                  fontSize: 12.0),
            ),
          )
        ],
      ));
}

Widget _bindText(id, controller) {
  return Container(
      decoration: BoxDecoration(
          color: AppColors.formBackground,
          border: Border.all(
              width: 0.95,
              color: AppColors.formBorder,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              AppUtils.textWithFirstLetterUppercase(controller.interests
                  .where((interest) => interest.id == id)
                  .first
                  .label),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Nunito',
                  decoration: TextDecoration.none,
                  color: AppColors.secondFont),
            ),
          )
        ],
      ));
}

Widget _bindGoals(id, controller) {
  return Flexible(
      flex: 1,
      child: Container(
        child: Text(
          AppUtils.textWithFirstLetterUppercase(
              controller.seeks.where((seek) => seek.id == id).first.label),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Nunito',
              decoration: TextDecoration.none,
              color: AppColors.fontGrayLight),
        ),
      ));
}
