// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileController on _ProfileBase, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ProfileBase.isFormValid'))
          .value;

  final _$isLoadingAtom = Atom(name: '_ProfileBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProfileBase.loading');

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

  final _$hasErrorAtom = Atom(name: '_ProfileBase.hasError');

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

  final _$errorDescriptionAtom = Atom(name: '_ProfileBase.errorDescription');

  @override
  String get errorDescription {
    _$errorDescriptionAtom.reportRead();
    return super.errorDescription;
  }

  @override
  set errorDescription(String value) {
    _$errorDescriptionAtom.reportWrite(value, super.errorDescription, () {
      super.errorDescription = value;
    });
  }

  final _$profileAtom = Atom(name: '_ProfileBase.profile');

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

  final _$birthHourControllerAtom =
      Atom(name: '_ProfileBase.birthHourController');

  @override
  TextEditingController get birthHourController {
    _$birthHourControllerAtom.reportRead();
    return super.birthHourController;
  }

  @override
  set birthHourController(TextEditingController value) {
    _$birthHourControllerAtom.reportWrite(value, super.birthHourController, () {
      super.birthHourController = value;
    });
  }

  final _$birthDateControllerAtom =
      Atom(name: '_ProfileBase.birthDateController');

  @override
  TextEditingController get birthDateController {
    _$birthDateControllerAtom.reportRead();
    return super.birthDateController;
  }

  @override
  set birthDateController(TextEditingController value) {
    _$birthDateControllerAtom.reportWrite(value, super.birthDateController, () {
      super.birthDateController = value;
    });
  }

  final _$birthCityControllerAtom =
      Atom(name: '_ProfileBase.birthCityController');

  @override
  TextEditingController get birthCityController {
    _$birthCityControllerAtom.reportRead();
    return super.birthCityController;
  }

  @override
  set birthCityController(TextEditingController value) {
    _$birthCityControllerAtom.reportWrite(value, super.birthCityController, () {
      super.birthCityController = value;
    });
  }

  final _$aboutControllerAtom = Atom(name: '_ProfileBase.aboutController');

  @override
  TextEditingController get aboutController {
    _$aboutControllerAtom.reportRead();
    return super.aboutController;
  }

  @override
  set aboutController(TextEditingController value) {
    _$aboutControllerAtom.reportWrite(value, super.aboutController, () {
      super.aboutController = value;
    });
  }

  final _$feedbackControllerAtom =
      Atom(name: '_ProfileBase.feedbackController');

  @override
  TextEditingController get feedbackController {
    _$feedbackControllerAtom.reportRead();
    return super.feedbackController;
  }

  @override
  set feedbackController(TextEditingController value) {
    _$feedbackControllerAtom.reportWrite(value, super.feedbackController, () {
      super.feedbackController = value;
    });
  }

  final _$emailControllerAtom = Atom(name: '_ProfileBase.emailController');

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  final _$photos_paramAtom = Atom(name: '_ProfileBase.photos_param');

  @override
  ObservableList<dynamic> get photos_param {
    _$photos_paramAtom.reportRead();
    return super.photos_param;
  }

  @override
  set photos_param(ObservableList<dynamic> value) {
    _$photos_paramAtom.reportWrite(value, super.photos_param, () {
      super.photos_param = value;
    });
  }

  final _$genresAtom = Atom(name: '_ProfileBase.genres');

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

  final _$interestsAtom = Atom(name: '_ProfileBase.interests');

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

  final _$waysOfLoveAtom = Atom(name: '_ProfileBase.waysOfLove');

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

  final _$seeksAtom = Atom(name: '_ProfileBase.seeks');

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

  final _$citiesAtom = Atom(name: '_ProfileBase.cities');

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

  final _$termsAtom = Atom(name: '_ProfileBase.terms');

  @override
  String get terms {
    _$termsAtom.reportRead();
    return super.terms;
  }

  @override
  set terms(String value) {
    _$termsAtom.reportWrite(value, super.terms, () {
      super.terms = value;
    });
  }

  final _$privacyAtom = Atom(name: '_ProfileBase.privacy');

  @override
  String get privacy {
    _$privacyAtom.reportRead();
    return super.privacy;
  }

  @override
  set privacy(String value) {
    _$privacyAtom.reportWrite(value, super.privacy, () {
      super.privacy = value;
    });
  }

  final _$feedbackAtom = Atom(name: '_ProfileBase.feedback');

  @override
  String get feedback {
    _$feedbackAtom.reportRead();
    return super.feedback;
  }

  @override
  set feedback(String value) {
    _$feedbackAtom.reportWrite(value, super.feedback, () {
      super.feedback = value;
    });
  }

  final _$isDateValidAtom = Atom(name: '_ProfileBase.isDateValid');

  @override
  bool get isDateValid {
    _$isDateValidAtom.reportRead();
    return super.isDateValid;
  }

  @override
  set isDateValid(bool value) {
    _$isDateValidAtom.reportWrite(value, super.isDateValid, () {
      super.isDateValid = value;
    });
  }

  final _$isHourValidAtom = Atom(name: '_ProfileBase.isHourValid');

  @override
  bool get isHourValid {
    _$isHourValidAtom.reportRead();
    return super.isHourValid;
  }

  @override
  set isHourValid(bool value) {
    _$isHourValidAtom.reportWrite(value, super.isHourValid, () {
      super.isHourValid = value;
    });
  }

  final _$isCityValidAtom = Atom(name: '_ProfileBase.isCityValid');

  @override
  bool get isCityValid {
    _$isCityValidAtom.reportRead();
    return super.isCityValid;
  }

  @override
  set isCityValid(bool value) {
    _$isCityValidAtom.reportWrite(value, super.isCityValid, () {
      super.isCityValid = value;
    });
  }

  final _$getCitiesSuggestionsAsyncAction =
      AsyncAction('_ProfileBase.getCitiesSuggestions');

  @override
  Future<List<String>> getCitiesSuggestions(String search) {
    return _$getCitiesSuggestionsAsyncAction
        .run(() => super.getCitiesSuggestions(search));
  }

  final _$getTermsAsyncAction = AsyncAction('_ProfileBase.getTerms');

  @override
  Future getTerms() {
    return _$getTermsAsyncAction.run(() => super.getTerms());
  }

  final _$getPrivacyAsyncAction = AsyncAction('_ProfileBase.getPrivacy');

  @override
  Future getPrivacy() {
    return _$getPrivacyAsyncAction.run(() => super.getPrivacy());
  }

  final _$getUserProfileAsyncAction =
      AsyncAction('_ProfileBase.getUserProfile');

  @override
  Future getUserProfile(bool searchParams) {
    return _$getUserProfileAsyncAction
        .run(() => super.getUserProfile(searchParams));
  }

  final _$savePartialProfileAsyncAction =
      AsyncAction('_ProfileBase.savePartialProfile');

  @override
  Future savePartialProfile(BuildContext context, List<String> fields) {
    return _$savePartialProfileAsyncAction
        .run(() => super.savePartialProfile(context, fields));
  }

  final _$saveConfigurationProfileAsyncAction =
      AsyncAction('_ProfileBase.saveConfigurationProfile');

  @override
  Future saveConfigurationProfile(BuildContext context) {
    return _$saveConfigurationProfileAsyncAction
        .run(() => super.saveConfigurationProfile(context));
  }

  final _$changeEmailAsyncAction = AsyncAction('_ProfileBase.changeEmail');

  @override
  Future changeEmail(BuildContext context) {
    return _$changeEmailAsyncAction.run(() => super.changeEmail(context));
  }

  final _$saveProfileAsyncAction = AsyncAction('_ProfileBase.saveProfile');

  @override
  Future saveProfile(BuildContext context) {
    return _$saveProfileAsyncAction.run(() => super.saveProfile(context));
  }

  final _$_ProfileBaseActionController = ActionController(name: '_ProfileBase');

  @override
  dynamic showCitySnack(BuildContext context) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.showCitySnack');
    try {
      return super.showCitySnack(context);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateEmail(String text) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.validateEmail');
    try {
      return super.validateEmail(text);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateBirthDate(String text) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.validateBirthDate');
    try {
      return super.validateBirthDate(text);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateBirthCity(bool validation) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.validateBirthCity');
    try {
      return super.validateBirthCity(validation);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic textWithFirstLetterUppercase(String text) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.textWithFirstLetterUppercase');
    try {
      return super.textWithFirstLetterUppercase(text);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOrRemoveSelectedLookingFor(String nameList, bool validacao) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction(
        name: '_ProfileBase.addOrRemoveSelectedLookingFor');
    try {
      return super.addOrRemoveSelectedLookingFor(nameList, validacao);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<T> map<T>(List<dynamic> list, Function handler) {
    final _$actionInfo =
        _$_ProfileBaseActionController.startAction(name: '_ProfileBase.map<T>');
    try {
      return super.map<T>(list, handler);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
loading: ${loading},
hasError: ${hasError},
errorDescription: ${errorDescription},
profile: ${profile},
birthHourController: ${birthHourController},
birthDateController: ${birthDateController},
birthCityController: ${birthCityController},
aboutController: ${aboutController},
feedbackController: ${feedbackController},
emailController: ${emailController},
photos_param: ${photos_param},
genres: ${genres},
interests: ${interests},
waysOfLove: ${waysOfLove},
seeks: ${seeks},
cities: ${cities},
terms: ${terms},
privacy: ${privacy},
feedback: ${feedback},
isDateValid: ${isDateValid},
isHourValid: ${isHourValid},
isCityValid: ${isCityValid},
isFormValid: ${isFormValid}
    ''';
  }
}
