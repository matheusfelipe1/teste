import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/home/home_controller.dart';
import 'package:joinder_app/app/modules/home/profile_detail/profile_detail_page.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

import 'package:joinder_app/app/shared/widgets/joinder_deck.dart';
import 'package:joinder_app/app/shared/models/card_model.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

import 'package:joinder_app/app/modules/chat/chat_controller.dart';

import '../chat/chat_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _headKey = new GlobalKey();
  final GlobalKey _bottomKey = new GlobalKey();
  final GlobalKey _deckKey = new GlobalKey();

  double _chatButtonPosition;

  HomeController _controller;
  ChatController _chatController;
  AuthController _authController;
  @override
  void initState() {
    super.initState();
    _controller = Modular.get<HomeController>();
    _chatController = Modular.get<ChatController>();
    _authController = Modular.get<AuthController>();
    getLocation();
  }

  getLocation() async {
    await _authController.geoLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.purple,
      child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Observer(
                builder: (_) {
                  return Container(
                    decoration:
                        BoxDecoration(gradient: _getBackgroundGradient()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          key: _headKey,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Image.asset('assets/images/profile.png'),
                                iconSize: 41.0,
                                onPressed: () {
                                  Modular.to.pushReplacementNamed('/profile');
                                },
                              ),
                              IconButton(
                                icon: Image.asset('assets/images/cards.png'),
                                iconSize: 41.0,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Image.asset('assets/images/more.png'),
                                iconSize: 24.0,
                                onPressed: () async {
                                  final result =
                                      await AppUtils.wantToDoDialog(context);
                                  if (result != null) {
                                    if (result['option'] == 1) {
                                      _controller.addToFridge(
                                          context,
                                          result['desc'],
                                          _controller.currentCard);
                                    } else if (result['option'] == 2) {
                                      _controller.reportUser(
                                          context,
                                          result['desc'],
                                          _controller.currentCard);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        _buildDeckObserver(),
                        Container(
                          key: _bottomKey,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: MediaQuery.of(context).padding.bottom),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: _controller.dequeuedCards.length > 0
                                    ? Image.asset('assets/images/back.png')
                                    : Image.asset(
                                        'assets/images/back_inactive.png'),
                                iconSize: 41.0,
                                onPressed: () {
                                  _controller.backCard();
                                },
                              ),
                              IconButton(
                                icon: Image.asset('assets/images/chat.png'),
                                iconSize: 41.0,
                                onPressed: () {
                                  Modular.to.pushNamed('/chat');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              _chatButton()
            ],
          )),
    ));
  }

  LinearGradient _getBackgroundGradient() {
    if (_controller.currentCard != null)
      switch (_controller.currentCard.type) {
        case CardType.profile:
          return LinearGradient(
              colors: [AppColors.white, AppColors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight);
        case CardType.content:
          return AppColors.contentGradient;
        case CardType.publicity:
          return AppColors.jihGradient;
        default:
          return LinearGradient(
              colors: [AppColors.white, AppColors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight);
      }
    else
      return LinearGradient(
          colors: [AppColors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
  }

  Widget _chatButton() {
    if (_chatButtonPosition != null)
      return Positioned(
        bottom: _chatButtonPosition,
        width: MediaQuery.of(context).size.width,
        child: Center(child: Observer(
          builder: (_) {
            if ((_controller.currentCard != null &&
                    _controller.currentCard.type == CardType.profile) &&
                (!_controller.isLoading && _controller.cards.length > 0))
              return Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.mainBorder,
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    if (!_controller.isButtonDisabled) {
                      _controller.isButtonDisabled = true;
                      _chatController.createChat(_controller.currentCard.id);                      
                    } else {
                      null;
                    }
                  },
                  backgroundColor: AppColors.formBackground,
                  elevation: 4,
                  child: _chatController.isLoading
                      ? CircularProgressIndicator()
                      : Image.asset(
                          'assets/images/chat_floating.png',
                          width: 20.0,
                        ),
                ),
              );
            else
              return Container();
            // Botão Chat Desabilitado.
            // else
            //   return Container(
            //     width: 60,
            //     height: 60,
            //     margin: EdgeInsets.only(bottom: 10.0),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //           color: AppColors.formBackground,
            //           width: 1.0,
            //           style: BorderStyle.solid),
            //       borderRadius: BorderRadius.circular(50.0),
            //     ),
            //     child: FloatingActionButton(
            //       onPressed: () {},
            //       backgroundColor: AppColors.formBackground,
            //       elevation: 2,
            //       child: Image.asset(
            //         'assets/images/chat_floating_inactive.png',
            //         width: 20.0,
            //       ),
            //     ),
            //   );
          },
        )),
      );
    else
      return Container();
  }

  void _calcChatButtonPosition() {
    Timer(Duration(milliseconds: 300), () {
      // Screen Height
      final screenHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top;
      // Head Height
      final headHeight = _headKey.currentContext.size.height;
      // Deck Height
      final deckHeight = _deckKey.currentContext.size.height <
              MediaQuery.of(context).size.width * 0.9 * 1.53
          ? _deckKey.currentContext.size.height
          : MediaQuery.of(context).size.width * 0.9 * 1.53;
      // Bottom Height
      final bottomHeight = _bottomKey.currentContext.size.height;
      // Space Between
      final spaceBetween =
          (screenHeight - headHeight - deckHeight - bottomHeight) / 2;
      setState(() {
        _chatButtonPosition =
            spaceBetween + 5 + MediaQuery.of(context).padding.bottom;
      });
    });
  }

  Widget _buildDeckObserver() {
    var joinderCards = _controller.cards.toList();
    if (joinderCards.length > 0) {
      _calcChatButtonPosition();
      return JoinderDeck(
        key: _deckKey,
        cards: joinderCards,
        onDequeue: (card) {
          _controller.removeCard(card);
        },
        onFinish: () {
          _controller.fillCards(false, true);
        },
        onCardChanged: (card) {
          _controller.currentCard = card;
        },
        onCardPressed: (card) {
          if (_controller.currentCard != null &&
              _controller.currentCard.type == CardType.profile)
            _controller.fillCardProfile(card);
          // TODO: Criar ação para publicidade e conteúdo.
        },
      );
    } else if (_controller.isLoading)
      return Flexible(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.purple)),
        ),
      );
    else
      return Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/pulse_home.gif',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/jih1.png',
                      height: 130,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Text(
                "Por enquanto não tem ninguem perto de você. Mas não desista, estamos aqui para aproximar você daquela pessoa que tem tudo a ver com você.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.mainFont,
                    fontFamily: 'Nunito'),
              ),
            ),
          ],
        ),
      );
  }
}
