import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/widgets/custom_checkbox.dart';
import 'package:joinder_app/app/shared/widgets/primary_button.dart';

import 'always_visible_scrollbar.dart';
import 'custom_chip.dart';
import 'custom_chip_love.dart';
import 'custom_outline_button.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class DefaultDialogProfile extends StatelessWidget {
  final String _contentBody;
  final dynamic _list;
  final dynamic _selectedList;

  List<String> genres = [
    "Mulher",
    "Homem",
    "Mulher Cisgênero",
    "Homem Cisgênero",
    "Mulher Transexual",
    "Homem Transexual",
    "Travesti",
    "Transgênero",
    "Não Binário",
    "Queer",
    "Intersexo",
    "Outro",
  ];

  List seeks = ['Namoro', 'Amizade', 'Pegação'];

  List interests = [
    "Atividades ao ar livre",
    "Esportes",
    "Lutas",
    "Séries",
    "Lanches",
    "Bons produtos",
    "Curiosidades",
    "Livros",
    "Dançar",
    "Cafuné",
    "Churras em família",
    "Receber flores",
    "Romance",
    "Teatro",
    "Canto",
    "Limpeza",
    "Jogos mentais",
    "Jardinagem",
    "Poesia",
    "Artes",
    "Pôr do sol",
    "Ocultimo",
    "Museus",
    "Filmes",
    "Viagens",
    "Aventuras",
    "Filosofias",
    "Economias",
    "Política",
    "Jantar a luz de velas",
    "Conversas longas",
    "Mesas de bar",
    "Tecnologia",
    "Espiritualidade",
    "Música",
    "Contos sobre magia",
  ];

  List ways_of_page = [
    {
      'icon': 'assets/images/ic_palavras_roxo.png',
      'iconLight': 'assets/images/ic_palavras_cinza.png',
      'title': "PALAVRAS DE AFIRMAÇÃO",
      'body':
          'Você faz elogios como: “O jantar estava ótimo”, afirmações como “Acho que você faz isso super bem” e/ou incentivos como “Vai dar tudo certo”.'
    },
    {
      'icon': 'assets/images/ic_tempo_roxo.png',
      'iconLight': 'assets/images/ic_tempo_cinza.png',
      'title': "QUALIDADE DE TEMPO",
      'body':
          'Dedica um tempo exclusivo ainda que pequeno? Passeio, assistir televisão juntos...'
    },
    {
      'icon': 'assets/images/ic_presente_roxo.png',
      'iconLight': 'assets/images/ic_presente_cinza.png',
      'title': "PRESENTES",
      'body':
          'Dá presentes? Não é o valor financeiro que importa, o amor pode ser expresso por meio de uma flor, um bilhetinho ou um bombom…'
    },
    {
      'icon': 'assets/images/ic_toque_roxo.png',
      'iconLight': 'assets/images/ic_toque_cinza.png',
      'title': "TOQUE FÍSICO",
      'body': 'Procura dar carinho, abraços, beijos, andar de mãos dadas?'
    },
    {
      'icon': 'assets/images/ic_gestos_roxo.png',
      'iconLight': 'assets/images/ic_gestos_cinza.png',
      'title': "GESTOS DE SERVIÇO",
      'body':
          'Gestos valem mais do que palavras. Lava uma louça, conserta algo que quebrou, ajuda com alguma coisa que você precisa?'
    }
  ];

  DefaultDialogProfile(
      {Key key,
      @required String contentBody,
      @required dynamic list,
      @required dynamic selectedList,
      String buttonText})
      : _contentBody = contentBody,
        _list = list,
        _selectedList = selectedList,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Material(
                color: AppColors.backgroundDialog,
                elevation: 0,
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(23, 10, 23, 20),
                      child: _dialogContent(context)),
                ))));
  }

  _dialogContent(BuildContext context) {
    if (_contentBody == 'interests') {
      return _bindInfoInterests(context);
    }
    if (_contentBody == 'waysOfLove') {
      return _bindInfoWaysOfLove();
    }
    if (_contentBody == 'genre') {
      return _bindInfoGenres(context);
    }
    if (_contentBody == 'seek') {
      return _bindInfoSeeks(context);
    }
  }

  _bindInfoInterests(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          bottom: 15.0,
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
          children: <Widget>[
            Flexible(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: AlwaysVisibleScrollbar.grid(
                      crossAxisCount: 2,
                      scrollbarColor: AppColors.support3,
                      padding: EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 0, bottom: 10.0),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 2.5,
                      children: map<Widget>(_list, (index, interest) {
                        return CustomChip(
                          onChanged: (val) {
                            addRemoveOption(interest.id, val);
                          },
                          text: textWithFirstLetterUppercase(interest.label),
                          value: _selectedList.where((valuePosition) => valuePosition == interest.id).length > 0,
                        );
                      }),
                    ))),
            _buttonsFooter()
          ],
        ));
  }

  _bindInfoGenres(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          bottom: 15.0,
        ),
        margin: EdgeInsets.only(top: 9.0),
        height: seeks.length * 140.0 > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : seeks.length * 140.0,
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
          children: <Widget>[
            Flexible(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: AlwaysVisibleScrollbar.grid(
                      crossAxisCount: 2,
                      scrollbarColor: AppColors.support3,
                      padding: EdgeInsets.only(
                          top: 10.0, left: 5.0, right: 10.0, bottom: 0.0),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 2.2,
                      children: map<Widget>(_list, (index, genre) {
                        return CustomCheckbox(
                          onChanged: (val) {
                            addRemoveOption(genre.id, val);
                          },
                          text: textWithFirstLetterUppercase(genre.label),
                          value: _selectedList.where((valuePosition) => valuePosition == genre.id).length > 0,
                        );
                      }),
                    ))),
            _buttonsFooter()
          ],
        ));
  }

  _bindInfoSeeks(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          bottom: 15.0,
        ),
        margin: EdgeInsets.only(top: 9.0),
        height: seeks.length * 100.0 > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : seeks.length * 100.0,
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
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'O que busco',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.mainFont,
                  fontSize: 16.0,
                  fontFamily: 'Nunito',
                ),
              ),
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 34.0),
            ),
            Flexible(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: AlwaysVisibleScrollbar.grid(
                      crossAxisCount: 1,
                      scrollbarColor: AppColors.support3,
                      padding: EdgeInsets.only(
                          top: 20.0, left: 5.0, right: 10.0, bottom: 10.0),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 5,
                      children: map<Widget>(_list, (index, seek) {
                        return CustomCheckbox(
                          onChanged: (val) {
                            addRemoveOption(seek.id, val);
                          },
                          text: textWithFirstLetterUppercase(seek.label),
                          value: _selectedList.where((valuePosition) => valuePosition == seek.id).length > 0,
                        );
                      }),
                    ))),
            _buttonsFooter()
          ],
        ));
  }

  _bindInfoWaysOfLove() {
    return Container(
        padding: EdgeInsets.only(
          bottom: 15.0,
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
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    itemCount: _list.length,
                    padding: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 0, bottom: 10.0),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: CustomChipLove(
                          onChanged: (val) {
                            addRemoveOption(_list[index].id, val);
                          },
                          icon: _list[index].icon,
                          iconLight: _list[index].iconLight,
                          textTitle: textWithFirstLetterUppercase(_list[index].title),
                          textBody: _list[index].description,
                          value: _selectedList.where((valuePosition) => valuePosition == _list[index].id).length > 0,
                        ),
                      );
                    })),
            _buttonsFooter()
          ],
        ));
  }

  _buttonsFooter() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 110,
            child: CustomOutlineButton(
              text: "CANCELAR",
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
          Container(
            width: 125,
            padding: EdgeInsets.only(left: 15),
            child: PrimaryButton(
              text: "OK",
              onPressed: () {
                Modular.to.pop(_selectedList);
              },
            ),
          )
        ],
      ),
    );
  }

  addRemoveOption(interest, val) {
    if (val == true) {
      _selectedList.add(interest);
    } else {
      _selectedList.remove(interest);
    }
  }

  textWithFirstLetterUppercase(String text) {
    List arrayWords = text.toString().split(' ');
    String textFormatted = '';
    for (var i = 0; i < arrayWords.length; i++) {
      String espacamento = i != 0 ? ' ' : '';
      textFormatted += espacamento +
          arrayWords[i][0].toUpperCase() +
          arrayWords[i].substring(1);
    }
    return textFormatted;
  }
}
