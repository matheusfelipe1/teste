import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';

import 'package:joinder_app/app/shared/widgets/always_visible_scrollbar.dart';
import 'package:joinder_app/app/shared/widgets/custom_chip.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';

import '../signup_controller.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  SignUpController _controller;

  List<String> interestsSelected = [];

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    if (_controller.profile.interestedIn == null) {
      _controller.profile.interestedIn = [];
    }
    interestsSelected = _controller.profile.interestedIn;
    if (interestsSelected.length > 0) {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
    _controller.getInterests();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            JihTip(
              imagePath: 'assets/images/jih1.png',
              text:
                  "Interesses? \nTenho, muitos...rs \nQualquer dia te conto,\nmas antes me conta\nsobre os seus?",
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Observer(builder: (_) {
                if (!_controller.loading) {
                  if (_controller.interests != null &&
                      _controller.interests.length > 0) {
                    return AlwaysVisibleScrollbar.grid(
                      crossAxisCount: 2,
                      padding: EdgeInsets.only(
                          top: 10.0, left: 23.0, right: 0, bottom: 10.0),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 2.8,
                      children:
                          map<Widget>(_controller.interests, (index, interest) {
                        return CustomChip(
                          onChanged: (val) {
                            interestsSelected = _controller.addOrRemoveSelected(
                                interest.id, interestsSelected, val);
                          },
                          text: _controller
                              .textWithFirstLetterUppercase(interest.label),
                          value: _controller.verifySelected(
                              interest.id, interestsSelected),
                        );
                      }),
                    );
                  } else {
                    return Text("Não encontramos nenhuma forma de amar :(");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
            )),
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
                          text: "PULAR",
                          onPressed: () {
                            _controller.setPage(11);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 12.0, right: 24.0),
                        child: Observer(builder: (_) {
                          return PrimaryButton(
                            text: "PRÓXIMO",
                            onPressed: _controller.isButtonDisabled
                                ? null
                                : () {
                                    setState(() {
                                      _controller.isButtonDisabled = true;
                                    });
                                    _controller.profile.interestedIn =
                                        interestsSelected;
                                    _controller.setPage(11);
                                  },
                          );
                        }),
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
