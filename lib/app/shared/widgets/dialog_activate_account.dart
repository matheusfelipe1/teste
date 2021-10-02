import 'package:flutter/material.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

class DialogActivateAccount extends StatelessWidget {
  // final String _title;
  // final String _description;
  // final String _subTitle;

  DialogActivateAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: _dialogContent(context),
        )));
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 21.0,
          ),
          margin: EdgeInsets.only(top: 9.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/ic_ativacao_conta.png',
                // 'assets/images/ic_carinha_delete.png',
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.0),
                child: Text(
                  'ATIVAÇÃO DE CONTA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                      color: AppColors.mainFont),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 19.0),
                padding: EdgeInsets.only(
                    top: 22.0, bottom: 22.0, left: 35.0, right: 35.0),
                color: AppColors.dialogBox,
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(11.0),
                    child: Text(
                      'IMPORTANTE! \n\n Para ativar sua conta, verifique seu email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0, color: AppColors.thirthFont),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _getButton(context),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 12.47,
          child: GestureDetector(
            child: Image.asset(
              'assets/images/close.png',
              height: 20.0,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget _getButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: PrimaryButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'OK',
      ),
    );
  }
}
