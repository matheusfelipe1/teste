import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/validators/validators.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';

import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';
import 'package:joinder_app/app/shared/models/ways.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

part 'profile_controller.g.dart';

class ProfileController = _ProfileBase with _$ProfileController;

abstract class _ProfileBase with Store {
  final _authController = Modular.get<AuthController>();
  final ISignUpRepository _signUpRepository = Modular.get();

  @observable
  bool isLoading;

  @observable
  bool loading;

  @observable
  bool hasError;

  @observable
  String errorDescription = "";

  @observable
  Profile profile;

  @observable
  TextEditingController birthHourController = new TextEditingController();

  @observable
  TextEditingController birthDateController = new TextEditingController();

  @observable
  TextEditingController birthCityController = new TextEditingController();

  @observable
  TextEditingController aboutController = new TextEditingController();

  @observable
  TextEditingController feedbackController = new TextEditingController();

  @observable
  TextEditingController emailController = new TextEditingController();

  @observable
  ObservableList photos_param = new ObservableList();

  @observable
  ObservableList<IdAndLabel> genres;

  @observable
  ObservableList<IdAndLabel> interests;

  @observable
  ObservableList<Ways> waysOfLove;

  @observable
  ObservableList<IdAndLabel> seeks;

  @observable
  List<String> cities;

  @observable
  String terms;

  @observable
  String privacy;

  @observable
  String feedback;

  // MARK: Form Validation Observables
  @computed
  bool get isFormValid =>
      isDateValid &&
      isCityValid &&
      profile.goals.length > 0 &&
      profile.genders.length > 0;

  @observable
  bool isDateValid = false;

  @observable
  bool isHourValid = false;

  @observable
  bool isCityValid = false;

  _ProfileBase() {
    _init();
  }

  _init() {}

  @action
  Future<List<String>> getCitiesSuggestions(String search) async {
    loading = true;
    cities = await _signUpRepository.getCitiesSuggestions(search);
    loading = false;
    return cities;
  }

  @action
  showCitySnack(BuildContext context) {
    _authController.showSnackbar(context, 'error',
        'Não encontramos a sua cidade. \nVerifique se foi escrita corretamente');
  }

  @action
  getTerms() async {
    isLoading = true;
    terms = await _signUpRepository.getTermsOfUse();
    isLoading = false;
  }

  @action
  getPrivacy() async {
    isLoading = true;
    privacy = await _signUpRepository.getPrivacy();
    isLoading = false;
  }

  @action
  getUserProfile(bool searchParams) async {
    isLoading = true;
    profile = new Profile();
    profile = await _authController.getUserProfile();
    // TODO: Pegar foto do signo.
    if (profile.photos.length == 0 && !searchParams)
      profile.photos.add(AppUtils.getSignImage(profile));
    if (profile == null) _authController.signOut();
    if (searchParams) {
      aboutController.text = profile.about;
      birthDateController.text = "${profile.birth.date}";
      birthHourController.text = "${profile.birth.time}";
      birthCityController.text = "${profile.birth.place.city}";
      isDateValid = true;
      isHourValid = true;
      isCityValid = true;
      photos_param = new ObservableList();
      var tamanho = profile.photos.length < 8 ? profile.photos.length + 1 : 8;
      for (var i = 0; i < tamanho; i++) {
        if (profile.photos.length > i) {
          photos_param.add(profile.photos[i]);
        } else {
          photos_param.add('');
        }
      }
      genres = ObservableList.of(await _signUpRepository.getGenders());
      waysOfLove = ObservableList.of(await _signUpRepository.getWayOfLoves());
      seeks = ObservableList.of(await _signUpRepository.getGoals());
      interests = ObservableList.of(await _signUpRepository.getInterests());
    }
    isLoading = false;
  }

  @action
  savePartialProfile(BuildContext context, List<String> fields) async {
    isLoading = true;
    final status = await _signUpRepository.patchProfile(profile, fields);
    switch (status) {
      case 204:
        Modular.to.pop();
        break;
      case 400:
        await AppUtils.defaultDialog(
            context,
            true,
            "UPS...",
            "Não conseguimos salvar seu perfil. Por favor verifique se você preencheu o campo.",
            true,
            buttonText: "OK");
        break;
      case 401:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Você não possui autorização para salvar o perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 404:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Não encontramos seu perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      default:
    }
    isLoading = false;
  }

  @action
  saveConfigurationProfile(BuildContext context) async {
    isLoading = true;
    try {
      final status = await _signUpRepository.postConfigurationProfile(profile);
      switch (status) {
        case 200:
          Modular.to.pop();
          break;
        case 400:
          await AppUtils.defaultDialog(
              context,
              true,
              "UPS...",
              "Não conseguimos salvar suas preferências. Por favor verifique todos os campos",
              true,
              buttonText: "OK");
          break;
        case 401:
          await AppUtils.defaultDialog(context, true, "UPS...",
              "Você não possui autorização para salvar o perfil :(", true,
              buttonText: "OK");
          _authController.signOut();
          break;
        case 404:
          await AppUtils.defaultDialog(
              context, true, "UPS...", "Não encontramos seu perfil :(", true,
              buttonText: "OK");
          _authController.signOut();
          break;
        default:
      }
    } catch (e) {
      await AppUtils.defaultDialog(
          context,
          true,
          "UPS...",
          "Não conseguimos salvar suas preferências. Por favor verifique todos os campos",
          true,
          buttonText: "OK");
    }
    isLoading = false;
  }

  @action
  changeEmail(BuildContext context) async {
    isLoading = true;
    try {
      final status = await _signUpRepository.patchProfileEmail(
          profile, emailController.text);
      switch (status) {
        case 204:
          await AppUtils.defaultDialog(
              context,
              false,
              "SUCESSO",
              "E-mail de verificação enviado. Confira seu e-mail, pleasseee ;)",
              true,
              buttonText: "OK");
          _authController.signOut();
          break;
        case 400:
          await AppUtils.defaultDialog(context, true, "UPS...",
              "O e-mail informado não pode ser utilizado.", true,
              buttonText: "OK");
          break;
        case 401:
          await AppUtils.defaultDialog(context, true, "UPS...",
              "Você não possui autorização para alterar o perfil :(", true,
              buttonText: "OK");
          _authController.signOut();
          break;
        case 404:
          await AppUtils.defaultDialog(
              context, true, "UPS...", "Não encontramos seu perfil :(", true,
              buttonText: "OK");
          _authController.signOut();
          break;
        default:
      }
    } catch (e) {
      await AppUtils.defaultDialog(
          context,
          true,
          "UPS...",
          "Não conseguimos salvar suas preferências. Por favor verifique todos os campos",
          true,
          buttonText: "OK");
    }
    isLoading = false;
  }

  @action
  saveProfile(BuildContext context) async {
    isLoading = true;
    final status = await _signUpRepository.putProfile(profile);
    switch (status) {
      case 200:
        getUserProfile(false);
        Modular.to.pop();
        break;
      case 400:
        await AppUtils.defaultDialog(
            context,
            true,
            "UPS...",
            "Não conseguimos salvar seu perfil. Por favor verifique todos os campos",
            true,
            buttonText: "OK");
        break;
      case 401:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Você não possui autorização para salvar o perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 404:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Não encontramos seu perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      default:
    }
    isLoading = false;
  }

  sendFeedback(BuildContext context) async {
    isLoading = true;
    final status = await _signUpRepository.sendFeedback(feedback);
    switch (status) {
      case 204:
        await AppUtils.defaultDialogChat(
          context,
          "AGRADECEMOS MUITOOOO\n SUA OPINIÃO",
          "",
          false,
          false,
          'assets/images/face.png',
          'Cada opinião, é uma oportunidade de mudar e tornar o joinder.me\n melhor. Obrigada',
          false,
          buttonText: "SAIR",
        );
        feedbackController.text = "";
        feedback = "";
        Modular.to.pop();
        break;
      case 400:
        await AppUtils.defaultDialog(
            context,
            true,
            "UPS...",
            "Não conseguimos salvar seu feedback. Por favor verifique todos os campos",
            true,
            buttonText: "OK");
        break;
      case 401:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Você não possui autorização para realizar o feedback :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 404:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Não encontramos seu perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 409:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Seu perfil não está mais ativo :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      default:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Ocorreu um erro inesperado: $status", true,
            buttonText: "OK");
        break;
    }
    isLoading = false;
  }

  deleteProfile(BuildContext context, String reason) async {
    isLoading = true;
    final status =
        await _signUpRepository.deleteProfile(_authController.profile, reason);
    switch (status) {
      case 201:
        Modular.get<AuthController>().signOut();
        break;
      case 204:
        Modular.get<AuthController>().signOut();
        break;
      case 400:
        await AppUtils.defaultDialog(
            context,
            true,
            "UPS...",
            "Não conseguimos deletar sua conta. Por favor verifique todos os campos",
            true,
            buttonText: "OK");
        break;
      case 401:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Você não possui autorização para deletar sua conta :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 404:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Não encontramos seu perfil :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      case 409:
        await AppUtils.defaultDialog(
            context, true, "UPS...", "Seu perfil não está mais ativo :(", true,
            buttonText: "OK");
        _authController.signOut();
        break;
      default:
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Ocorreu um erro inesperado: $status", true,
            buttonText: "OK");
        break;
    }
    isLoading = false;
  }

  // MARK: Form Validation
  @action
  String validateEmail(String text) {
    if (Validators.isValidEmail(text)) {
      return null;
    } else {
      return 'Email digitado não é válido';
    }
  }

  @action
  String validateBirthDate(String text) {
    var validBirthDate = Validators.isValidBirthDate(text);
    if (validBirthDate == 'valid') {
      isDateValid = true;
      return null;
    } else {
      isDateValid = false;
      return validBirthDate;
    }
  }

  @action
  String validateBirthCity(bool validation) {
    isCityValid = validation;
  }

  String validateBirthHour(String text) {
    if (Validators.isValidBirthHour(text)) {
      isHourValid = true;
      return null;
    } else {
      isHourValid = false;
      return "Horário com o formato inválido";
    }
  }

  // MARK: Utils
  @action
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

  @action
  addOrRemoveSelectedLookingFor(String nameList, bool validacao) {
    validacao
        ? profile.lookingFor.add(nameList)
        : profile.lookingFor.remove(nameList);
    return profile.lookingFor;
  }

  @action
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
