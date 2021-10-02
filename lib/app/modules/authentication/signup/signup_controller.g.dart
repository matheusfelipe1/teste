// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpBase, Store {
  final _$pageAtom = Atom(name: '_SignUpBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_SignUpBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$pageTitleAtom = Atom(name: '_SignUpBase.pageTitle');

  @override
  String get pageTitle {
    _$pageTitleAtom.reportRead();
    return super.pageTitle;
  }

  @override
  set pageTitle(String value) {
    _$pageTitleAtom.reportWrite(value, super.pageTitle, () {
      super.pageTitle = value;
    });
  }

  final _$hasErrorAtom = Atom(name: '_SignUpBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$isButtonDisabledAtom = Atom(name: '_SignUpBase.isButtonDisabled');

  @override
  bool get isButtonDisabled {
    _$isButtonDisabledAtom.reportRead();
    return super.isButtonDisabled;
  }

  @override
  set isButtonDisabled(bool value) {
    _$isButtonDisabledAtom.reportWrite(value, super.isButtonDisabled, () {
      super.isButtonDisabled = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_SignUpBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$snackBarMessageAtom = Atom(name: '_SignUpBase.snackBarMessage');

  @override
  String get snackBarMessage {
    _$snackBarMessageAtom.reportRead();
    return super.snackBarMessage;
  }

  @override
  set snackBarMessage(String value) {
    _$snackBarMessageAtom.reportWrite(value, super.snackBarMessage, () {
      super.snackBarMessage = value;
    });
  }

  final _$profileAtom = Atom(name: '_SignUpBase.profile');

  @override
  Profile get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$genresAtom = Atom(name: '_SignUpBase.genres');

  @override
  ObservableList<IdAndLabel> get genres {
    _$genresAtom.reportRead();
    return super.genres;
  }

  @override
  set genres(ObservableList<IdAndLabel> value) {
    _$genresAtom.reportWrite(value, super.genres, () {
      super.genres = value;
    });
  }

  final _$genresIAmAtom = Atom(name: '_SignUpBase.genresIAm');

  @override
  ObservableList<String> get genresIAm {
    _$genresIAmAtom.reportRead();
    return super.genresIAm;
  }

  @override
  set genresIAm(ObservableList<String> value) {
    _$genresIAmAtom.reportWrite(value, super.genresIAm, () {
      super.genresIAm = value;
    });
  }

  final _$genresLookingForAtom = Atom(name: '_SignUpBase.genresLookingFor');

  @override
  ObservableList<String> get genresLookingFor {
    _$genresLookingForAtom.reportRead();
    return super.genresLookingFor;
  }

  @override
  set genresLookingFor(ObservableList<String> value) {
    _$genresLookingForAtom.reportWrite(value, super.genresLookingFor, () {
      super.genresLookingFor = value;
    });
  }

  final _$interestsAtom = Atom(name: '_SignUpBase.interests');

  @override
  ObservableList<IdAndLabel> get interests {
    _$interestsAtom.reportRead();
    return super.interests;
  }

  @override
  set interests(ObservableList<IdAndLabel> value) {
    _$interestsAtom.reportWrite(value, super.interests, () {
      super.interests = value;
    });
  }

  final _$waysOfLoveAtom = Atom(name: '_SignUpBase.waysOfLove');

  @override
  ObservableList<Ways> get waysOfLove {
    _$waysOfLoveAtom.reportRead();
    return super.waysOfLove;
  }

  @override
  set waysOfLove(ObservableList<Ways> value) {
    _$waysOfLoveAtom.reportWrite(value, super.waysOfLove, () {
      super.waysOfLove = value;
    });
  }

  final _$seeksAtom = Atom(name: '_SignUpBase.seeks');

  @override
  ObservableList<IdAndLabel> get seeks {
    _$seeksAtom.reportRead();
    return super.seeks;
  }

  @override
  set seeks(ObservableList<IdAndLabel> value) {
    _$seeksAtom.reportWrite(value, super.seeks, () {
      super.seeks = value;
    });
  }

  final _$citiesAtom = Atom(name: '_SignUpBase.cities');

  @override
  List<String> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<String> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_SignUpBase.showPassword');

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  final _$loadingAtom = Atom(name: '_SignUpBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$sendingAtom = Atom(name: '_SignUpBase.sending');

  @override
  bool get sending {
    _$sendingAtom.reportRead();
    return super.sending;
  }

  @override
  set sending(bool value) {
    _$sendingAtom.reportWrite(value, super.sending, () {
      super.sending = value;
    });
  }

  final _$currentPictureAtom = Atom(name: '_SignUpBase.currentPicture');

  @override
  String get currentPicture {
    _$currentPictureAtom.reportRead();
    return super.currentPicture;
  }

  @override
  set currentPicture(String value) {
    _$currentPictureAtom.reportWrite(value, super.currentPicture, () {
      super.currentPicture = value;
    });
  }

  final _$hasUploadErrorAtom = Atom(name: '_SignUpBase.hasUploadError');

  @override
  bool get hasUploadError {
    _$hasUploadErrorAtom.reportRead();
    return super.hasUploadError;
  }

  @override
  set hasUploadError(bool value) {
    _$hasUploadErrorAtom.reportWrite(value, super.hasUploadError, () {
      super.hasUploadError = value;
    });
  }

  final _$uploadErrorMessageAtom = Atom(name: '_SignUpBase.uploadErrorMessage');

  @override
  String get uploadErrorMessage {
    _$uploadErrorMessageAtom.reportRead();
    return super.uploadErrorMessage;
  }

  @override
  set uploadErrorMessage(String value) {
    _$uploadErrorMessageAtom.reportWrite(value, super.uploadErrorMessage, () {
      super.uploadErrorMessage = value;
    });
  }

  final _$pickImageAsyncAction = AsyncAction('_SignUpBase.pickImage');

  @override
  Future pickImage(ImageSource source) {
    return _$pickImageAsyncAction.run(() => super.pickImage(source));
  }

  final _$getCitiesSuggestionsAsyncAction =
      AsyncAction('_SignUpBase.getCitiesSuggestions');

  @override
  Future<List<String>> getCitiesSuggestions(String search) {
    return _$getCitiesSuggestionsAsyncAction
        .run(() => super.getCitiesSuggestions(search));
  }

  final _$getGenresAsyncAction = AsyncAction('_SignUpBase.getGenres');

  @override
  Future getGenres() {
    return _$getGenresAsyncAction.run(() => super.getGenres());
  }

  final _$getWayOfLovesAsyncAction = AsyncAction('_SignUpBase.getWayOfLoves');

  @override
  Future getWayOfLoves() {
    return _$getWayOfLovesAsyncAction.run(() => super.getWayOfLoves());
  }

  final _$getGoalsAsyncAction = AsyncAction('_SignUpBase.getGoals');

  @override
  Future getGoals() {
    return _$getGoalsAsyncAction.run(() => super.getGoals());
  }

  final _$getInterestsAsyncAction = AsyncAction('_SignUpBase.getInterests');

  @override
  Future getInterests() {
    return _$getInterestsAsyncAction.run(() => super.getInterests());
  }

  final _$saveUserAsyncAction = AsyncAction('_SignUpBase.saveUser');

  @override
  Future saveUser(BuildContext context) {
    return _$saveUserAsyncAction.run(() => super.saveUser(context));
  }

  final _$_SignUpBaseActionController = ActionController(name: '_SignUpBase');

  @override
  dynamic showCitySnack(BuildContext context) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.showCitySnack');
    try {
      return super.showCitySnack(context);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int newPage) {
    final _$actionInfo =
        _$_SignUpBaseActionController.startAction(name: '_SignUpBase.setPage');
    try {
      return super.setPage(newPage);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tryAgain() {
    final _$actionInfo =
        _$_SignUpBaseActionController.startAction(name: '_SignUpBase.tryAgain');
    try {
      return super.tryAgain();
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onBack() {
    final _$actionInfo =
        _$_SignUpBaseActionController.startAction(name: '_SignUpBase.onBack');
    try {
      return super.onBack();
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValidity(bool value) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.setValidity');
    try {
      return super.setValidity(value);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateEmail(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.validateEmail');
    try {
      return super.validateEmail(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateName(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.validateName');
    try {
      return super.validateName(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateBirthDate(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.validateBirthDate');
    try {
      return super.validateBirthDate(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateAbout(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.validateAbout');
    try {
      return super.validateAbout(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validatePassword(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.validatePassword');
    try {
      return super.validatePassword(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifySelected(String nameList, List<dynamic> array) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.verifySelected');
    try {
      return super.verifySelected(nameList, array);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOrRemoveSelected(String nameList, dynamic array, bool validacao) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.addOrRemoveSelected');
    try {
      return super.addOrRemoveSelected(nameList, array, validacao);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic textWithFirstLetterUppercase(String text) {
    final _$actionInfo = _$_SignUpBaseActionController.startAction(
        name: '_SignUpBase.textWithFirstLetterUppercase');
    try {
      return super.textWithFirstLetterUppercase(text);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<T> map<T>(List<dynamic> list, Function handler) {
    final _$actionInfo =
        _$_SignUpBaseActionController.startAction(name: '_SignUpBase.map<T>');
    try {
      return super.map<T>(list, handler);
    } finally {
      _$_SignUpBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
pageController: ${pageController},
pageTitle: ${pageTitle},
hasError: ${hasError},
isButtonDisabled: ${isButtonDisabled},
errorMessage: ${errorMessage},
snackBarMessage: ${snackBarMessage},
profile: ${profile},
genres: ${genres},
genresIAm: ${genresIAm},
genresLookingFor: ${genresLookingFor},
interests: ${interests},
waysOfLove: ${waysOfLove},
seeks: ${seeks},
cities: ${cities},
showPassword: ${showPassword},
loading: ${loading},
sending: ${sending},
currentPicture: ${currentPicture},
hasUploadError: ${hasUploadError},
uploadErrorMessage: ${uploadErrorMessage}
    ''';
  }
}
