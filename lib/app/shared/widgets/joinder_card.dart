import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/models/card_model.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

class JoinderCard extends StatelessWidget {
  final Function(CardModel) _onPressed;
  final CardModel _card;

  JoinderCard({Key key, CardModel card, Function(CardModel) onPressed})
      : _card = card,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(_card.type == CardType.publicity &&
            _card.name != null &&
            _card.name != '')) {}
        _onPressed(_card);
      },
      child: Material(
        elevation: 3,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: _card.type == CardType.profile
            ? Color.fromRGBO(200, 200, 200, 0.4)
            : Color.fromRGBO(157, 108, 150, 0.8),
        child: Stack(
          children: <Widget>[
            // Joinder Image
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: _card.photos.length > 0
                    ? _card.photos.first
                    : AppUtils.getSignImageCard(_card.sign),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            // Shadow Mask
            if (_card.type == CardType.profile)
              SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                      // 0.1425
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(colors: [
                        Colors.transparent,
                        Colors.black12,
                        Colors.black26,
                        Colors.black38,
                        Colors.black45,
                        Colors.black54,
                        Colors.black87,
                        Colors.black
                      ], stops: [
                        0.0,
                        0.30,
                        0.5,
                        0.6,
                        0.65,
                        0.72,
                        0.92,
                        1
                      ], begin: Alignment.center, end: Alignment.topCenter)),
                ),
              ),
            // Top Description
            if (_card.type == CardType.profile)
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(top: 18.0, left: 16.0, right: 16.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: AppUtils.getSignCard(_card.sign),
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: _card.content == 'white'
                                      ? AppColors.white
                                      : AppColors.getSignColor(_card.sign),
                                  fontFamily: 'Shink')),
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${_card.percent}%',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito')),
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            // Bottom Description
            if (_card.type == CardType.profile)
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 16.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${_card.name} ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3.0,
                                      color: Colors.black87,
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                  fontFamily: 'Nunito')),
                          TextSpan(
                              text: _card.age.toString(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: AppColors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3.0,
                                      color: Colors.black87,
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                  fontFamily: 'Nunito')),
                        ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            // Publicity Button
            if (_card.type == CardType.publicity &&
                _card.name != null &&
                _card.name != '')
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 16.0),
                      child: PrimaryButton(
                        onPressed: () {
                          _onPressed(_card);
                        },
                        text: _card.name,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
