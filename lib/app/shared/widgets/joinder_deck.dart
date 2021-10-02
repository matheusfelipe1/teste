// import 'dart:math';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/models/card_model.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/joinder_card.dart';

class JoinderDeck extends StatefulWidget {
  final VoidCallback _onFinish;
  final Function(CardModel) _onDequeue;
  final Function(CardModel) _onCardChanged;
  final Function(CardModel) _onCardPressed;
  final List<CardModel> _cards;

  JoinderDeck(
      {Key key,
      VoidCallback onFinish,
      Function(CardModel) onDequeue,
      Function(CardModel) onCardChanged,
      Function(CardModel) onCardPressed,
      List<CardModel> cards})
      : _onFinish = onFinish,
        _onDequeue = onDequeue,
        _onCardChanged = onCardChanged,
        _onCardPressed = onCardPressed,
        _cards = cards.reversed.toList(),
        super(key: key);

  @override
  _JoinderDeckState createState() => _JoinderDeckState();
}

class _JoinderDeckState extends State<JoinderDeck>
    with TickerProviderStateMixin {
  VoidCallback get _onFinish => widget._onFinish;
  Function(CardModel) get _onDequeue => widget._onDequeue;
  Function(CardModel) get _onCardChanged => widget._onCardChanged;
  Function(CardModel) get _onCardPressed => widget._onCardPressed;
  List<CardModel> get _cards => widget._cards;

  AnimationController _animationController;
  List<CardModel> cards = new List<CardModel>();

  @override
  void initState() {
    super.initState();
    cards = _cards;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cards.length > 0
          ? Stack(
              children: cards.map((item) {
              var card = JoinderCard(
                card: item,
                onPressed: _onCardPressed,
              );
              return Draggable(
                onDragEnd: (drag) {
                  if (drag.offset.dx < -80 || drag.offset.dx > 80)
                    _removeCard(item);
                },
                childWhenDragging: Container(),
                feedback: Align(
                  alignment: Alignment(0.0, 0.0),
                  child: SizedBox.fromSize(
                    size: Size(MediaQuery.of(context).size.width * 0.87,
                        MediaQuery.of(context).size.width * 0.9 * 1.53),
                    child: card,
                  ),
                ),
                child: Align(
                  alignment: Alignment(0.0, 0.0),
                  child: SizedBox.fromSize(
                    size: Size(MediaQuery.of(context).size.width * 0.87,
                        MediaQuery.of(context).size.width * 0.9 * 1.53),
                    child: card,
                  ),
                ),
              );
            }).toList())
          : Container(),
    );
  }

  void _removeCard(CardModel item) {
    _onDequeue(item);
    if (cards.length == 1) _onFinish();
    setState(() {
      cards.remove(item);
    });
    if (cards.length > 0) _onCardChanged(cards.last);
  }
}
