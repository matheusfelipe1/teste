import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';
import 'package:joinder_app/app/modules/home/home_controller.dart';
import 'package:joinder_app/app/shared/models/card_model.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

import 'package:icon_shadow/icon_shadow.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

import 'carousel_pro.dart';

class CustomCarouselPhotos extends StatefulWidget {
  final List _photos;
  final String _name;
  final String _age;
  final CardModel _profile;

  CustomCarouselPhotos(
      {Key key, List photos, String name, String age, CardModel profile})
      : _photos = photos,
        _name = name,
        _age = age,
        _profile = profile,
        super(key: key);

  @override
  _CustomCarouselPhotosState createState() => _CustomCarouselPhotosState();
}

class _CustomCarouselPhotosState extends State<CustomCarouselPhotos> {
  HomeController _homeController;
  ChatController _chatController;
  List get _photos => widget._photos;
  String get _name => widget._name;
  String get _age => widget._age;
  CardModel get _profile => widget._profile;
  List photos = [];
  String name;
  String age;
  int _current = 0;
  CardModel profile;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    photos = _photos;
    name = _name;
    age = _age;
    profile = _profile;
    _homeController = Modular.get<HomeController>();
    _chatController = Modular.get<ChatController>();
    // _photos.forEach((photo) => {
    //       photos.add(Image.asset(
    //         photo,
    //         fit: BoxFit.cover,
    //       ))
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return _bindCarousel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bindCarousel() {
    var carousel = CarouselSlider(
      autoPlay: false,
      autoPlayAnimationDuration: Duration(seconds: 0),
      viewportFraction: 1.0,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      aspectRatio: MediaQuery.of(context).size.aspectRatio,
      items: photos.map(
        (url) {
          print(url);
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          );
        },
      ).toList(),
    );
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.mainFontOpacity4,
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.80,
            width: MediaQuery.of(context).size.width,
            child: carousel,
          ),
        ),
        Positioned(
          bottom: 22,
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: name,
                    style: TextStyle(
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 1.0),
                          ),
                        ],
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito')),
                TextSpan(
                    text: ' ${age}',
                    style: TextStyle(
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 1.0),
                          ),
                        ],
                        color: AppColors.white,
                        fontFamily: 'Nunito')),
              ]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          width: 24,
          right: 20,
          top: 13,
          child: GestureDetector(
            onTap: () async {
              final result = await AppUtils.wantToDoDialog(context);
              if (result != null) {
                if (result['option'] == 1) {
                  _homeController.addToFridge(context, result['desc'], profile);
                } else if (result['option'] == 2) {
                  _homeController.reportUser(context, result['desc'], profile);
                }
              }
            },
            child: IconShadowWidget(
              Icon(Icons.more_vert, color: AppColors.white, size: 28),
              shadowColor: AppColors.blackOpacity25,
              showShadow: true,
            ),
          ),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            // height: 20,
            bottom: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  photos,
                  (index, url) {
                    var tamanho =
                        MediaQuery.of(context).size.width / photos.length - 10;
                    return Container(
                      width: tamanho > 33 ? 33 : tamanho,
                      height: 3.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color: _current == index
                              ? Color.fromRGBO(255, 255, 255, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4)),
                    );
                  },
                ),
              ),
            )),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 170,
          top: 50,
          child: GestureDetector(
            onTap: () {
              carousel.previousPage(
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            },
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.4,
          left: MediaQuery.of(context).size.width * 0.6,
          height: 170,
          top: 50,
          child: GestureDetector(
            onTap: () {
              carousel.nextPage(
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            },
          ),
        ),
      ],
    );
  }
}
