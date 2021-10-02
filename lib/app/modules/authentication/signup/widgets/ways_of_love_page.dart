import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/models/ways.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/custom_chip_love.dart';
import 'package:joinder_app/app/shared/widgets/custom_outline_button.dart';
import 'package:joinder_app/app/shared/widgets/jih_tip.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import '../signup_controller.dart';

class WaysOfLovesPage extends StatefulWidget {
  @override
  _WaysOfLovesPageState createState() => _WaysOfLovesPageState();
}

class _WaysOfLovesPageState extends State<WaysOfLovesPage> {
  SignUpController _controller;
  List ways_of_love_selected;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<SignUpController>();
    if (_controller.profile.waysOfLove == null) {
      _controller.profile.waysOfLove = [];
    }
    ways_of_love_selected = _controller.profile.waysOfLove;
    if (ways_of_love_selected.length > 0) {
      setState(() {
        _controller.isButtonDisabled = false;
      });
    }
    _controller.getWayOfLoves();
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
                  "Só mais um pouco\nsobre você e vamos\npara o que você\nprocura, ok?\nPrometo!",
            ),
            Flexible(child: Observer(builder: (_) {
              if (!_controller.loading) {
                if (_controller.waysOfLove != null &&
                    _controller.waysOfLove.length > 0) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          for (var item in _controller.waysOfLove)
                            Container(
                              margin: EdgeInsets.only(left: 20.0, bottom: 20.0),
                              child: CustomChipLove(
                                onChanged: (val) {
                                  ways_of_love_selected =
                                      _controller.addOrRemoveSelected(
                                          item.id, ways_of_love_selected, val);
                                },
                                icon: item.icon,
                                iconLight: item.iconLight,
                                textTitle: item.title.toUpperCase(),
                                textBody: item.description,
                                value: _controller.verifySelected(
                                    item.id, ways_of_love_selected),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text("Não encontramos nenhuma forma de amar :(");
                }
              } else {
                return CircularProgressIndicator();
              }
            })),
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
                            _controller.setPage(12);
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
                                      _controller.profile.waysOfLove =
                                          ways_of_love_selected;
                                      _controller.setPage(12);
                                    },
                            );
                          }))
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
