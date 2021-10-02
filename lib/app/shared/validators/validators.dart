class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _nameRegExp = RegExp(
    r'.{3,}',
  );
  static final RegExp _birthDateRegExp = RegExp(
    r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidName(String nome) {
    return _nameRegExp.hasMatch(nome);
  }

  static isValidBirthDate(String dataNasc) {
    if (_birthDateRegExp.hasMatch(dataNasc)) {
      // Nessa função verifica se o usuário digitou uma data maior que a atual e se ele tem 18 anos ou mais.
      return validBirthDateUser(dataNasc);
    } else {
      return 'Data com o formato inválido';
    }
  }

  static isValidBirthHour(String hourNasc) {
    if (hourNasc == '') {
      return true;
    } else {
      List dataQuebrada = hourNasc.split(':');
      if (dataQuebrada.length == 2) {
        if (int.parse(dataQuebrada[0].toString()) < 24 &&
            int.parse(dataQuebrada[1].toString()) < 60 &&
            dataQuebrada[0].length == 2 &&
            dataQuebrada[1].length == 2) {
          return true;
        }
      }
    }
    return false;
  }

  static isValidAbout(String about) {
    return about.length <= 500;
  }

  static isValidPassword(String password) {
    return password.length >= 6 && password.length <= 30;
  }

  static validBirthDateUser(String dataNasc) {
    int counterYersBissestos = 0;

    // Seta a data para no último instante do dia => 23:59:99:99
    var dateUserFormated = formatDate(dataNasc, 'string');

    // Seta a data para no último instante do dia => 23:59:99:99
    var dateNow = DateTime.now().toUtc();
    var dateNowFormated = formatDate(dateNow, 'date');
    // Verifica se a data inserida é maior que a data de hoje
    if (dateNowFormated.isBefore(dateUserFormated)) {
      return 'Você deve ter 18 anos ou mais';
    }

    //Pega a diferença entre a data atual e data de nascimento
    var difference = dateNowFormated.difference(dateUserFormated);

    //Pega a diferença de anos entre a data de nascimento e atual para saber quantos anos bissextos existem
    var differenceYear = dateNowFormated.year - dateUserFormated.year;

    // Verifica quantos anos bissextos existem
    for (var i = 0; i < differenceYear + 1; i++) {
      int anoAvaliar = dateUserFormated.year + i;
      if (((anoAvaliar % 4 == 0) && (anoAvaliar % 100 != 0)) ||
          (anoAvaliar % 400 == 0)) {
        counterYersBissestos++;
      }
    }

    // Retira das diferença de dias (a quantidade de anos bissextos), simulando como se todos os anos tivessem 365 dias
    double differenceDatesInDays =
        (difference.inDays - counterYersBissestos) / 365;

    // Condição do usário ter maior que 18 anos para acessar o app
    if (differenceDatesInDays < 18) {
      return 'Você deve ter 18 anos ou mais';
    } else {
      return 'valid';
    }
  }

  static formatDate(date, format) {
    List dateQuebrada;
    DateTime dateFormated;
    if (format == 'date') {
      dateQuebrada = date.toString().split(' ')[0].split('-');

      dateFormated = new DateTime(
          int.parse(dateQuebrada[0]),
          int.parse(dateQuebrada[1]),
          int.parse(dateQuebrada[2]),
          0,
          0,
          0);
    } else {
      dateQuebrada = date.split('/');
      dateFormated = new DateTime(
          int.parse(dateQuebrada[2]),
          int.parse(dateQuebrada[1]),
          int.parse(dateQuebrada[0]),
          0,
          0,
          0,);
    }
    return dateFormated;
  }
}
