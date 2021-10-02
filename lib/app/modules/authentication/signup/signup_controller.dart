import 'dart:io';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';
import 'package:joinder_app/app/shared/models/ways.dart';

import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';

import 'package:joinder_app/app/shared/validators/validators.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_controller.g.dart';

class SignUpController = _SignUpBase with _$SignUpController;

abstract class _SignUpBase with Store {
  final ISignUpRepository _signUpRepository = Modular.get();
  final _authController = Modular.get<AuthController>();

  @observable
  int page = 0;

  @observable
  PageController pageController;

  @observable
  String pageTitle = "";

  @observable
  bool hasError = false;

  @observable
  bool isButtonDisabled = false;

  @observable
  String errorMessage = "";

  @observable
  String snackBarMessage = "";

  @observable
  Profile profile;

  @observable
  ObservableList<IdAndLabel> genres;

  @observable
  ObservableList<String> genresIAm;

  @observable
  ObservableList<String> genresLookingFor;

  @observable
  ObservableList<IdAndLabel> interests;

  @observable
  ObservableList<Ways> waysOfLove;

  @observable
  ObservableList<IdAndLabel> seeks;

  @observable
  List<String> cities;

  @observable
  bool showPassword;

  @observable
  bool loading;

  @observable
  bool sending = false;

  @observable
  String currentPicture = "";

  @observable
  bool hasUploadError = false;

  @observable
  String uploadErrorMessage = "";

  _SignUpBase({int initialPage}) {
    if (initialPage != null) page = initialPage;
    _init();
  }

  _init() async {
    profile = new Profile();
    pageController = PageController(initialPage: page);
    pageTitle = _getPageTitle();
  }

  @action
  pickImage(ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: source);
      var lengthImage = image.lengthSync();
      setPage(2);

      if (image != null) {
        if (lengthImage <= 1000000) {
          final connectivityResult = await (Connectivity().checkConnectivity());
          setPage(2);
          profile.photos = new List<String>();
          if (connectivityResult != ConnectivityResult.none) {
            String url = await _signUpRepository.uploadProfileImage(image);
            if (url != null && url != "") {
              currentPicture = url;
              profile.photos = [currentPicture];
            } else {
              hasUploadError = true;
              uploadErrorMessage = "Erro ao carregar sua foto :(";
            }
          } else {
            hasUploadError = true;
            uploadErrorMessage = "Falha ao conectar ao servidor :(";
          }
        } else {
          hasUploadError = true;
          uploadErrorMessage = "Foto muito grande, tamanho máximo 1MB :(";
        }
      } else {
        hasUploadError = true;
        uploadErrorMessage = "Erro ao carregar sua foto :(";
      }
    } catch (e) {
      hasUploadError = true;
      uploadErrorMessage = "Erro ao carregar sua foto :(";
    }
  }

  @action
  Future<List<String>> getCitiesSuggestions(String search) async {
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
  getGenres() async {
    loading = true;
    genres = ObservableList.of(await _signUpRepository.getGenders());
    loading = false;
  }

  @action
  getWayOfLoves() async {
    loading = true;
    waysOfLove = ObservableList.of(await _signUpRepository.getWayOfLoves());
    loading = false;
  }

  @action
  getGoals() async {
    loading = true;
    seeks = ObservableList.of(await _signUpRepository.getGoals());
    loading = false;
  }

  @action
  getInterests() async {
    loading = true;
    interests = ObservableList.of(await _signUpRepository.getInterests());
    loading = false;
  }

  @action
  saveUser(BuildContext context) async {
    try {
      sending = true;
      bool emailExists = await verifyEmailExists(profile.email, context);
      if (!emailExists) {
        await getLocation();
        if (_authController.currentUser != null &&
            _authController.currentUser.email == profile.email) {
          await postProfile(context);
        } else {
          bool userCriado =
              await _authController.createUserWithEmailAndPassword(
                  profile.email, profile.password, context);
          if (userCriado) {
            await postProfile(context);
          }
        }
      }
      sending = false;
    } catch (e) {
      _authController.showSnackbar(
          context, 'warning', 'Ups... \nNão conseguimos salvar seu perfil :(');
      sending = false;
    }
  }

  postProfile(BuildContext context) async {
    try {
      final status = await _signUpRepository.postProfile(profile);
      if (status == 200 || status == 201) {
        await _authController.onAuthStatus();
        if (!_authController.isEmailActivated)
          await AppUtils.dialogActivateAccount(context);
        _authController.onStateChanged();
      } else {
        await AppUtils.defaultDialog(context, true, "UPS...",
            "Não conseguimos salvar seu perfil :(", true,
            buttonText: "OK");
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> verifyEmailExists(String email, BuildContext context) async {
    try {
      final result = await _signUpRepository.verifyEmailExists(email, context);
      print(" eroo $result");
      switch (result) {
        case 200:
          _authController.showSnackbar(
              context, 'warning', 'Ups... \n Este e-mail já está sendo usado!');
          return true;
          break;
        case 404:
          return false;
          break;
        default:
          _authController.showSnackbar(context, 'warning',
              'Ups... \n Erro ao consultar o seu e-mail :(');
          return true;
      }
    } catch (e) {
      return true;
    }
  }

  getLocation() async {
    await _authController.geoLocation();
    profile.location = new MapLocation(
        latitude: _authController.locationData.latitude,
        longitude: _authController.locationData.longitude);
  }

  // MARK: Controller Functions
  @action
  void setPage(int newPage) {
    page = newPage;
    pageTitle = _getPageTitle();
    pageController.animateToPage(newPage,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @action
  void tryAgain() {
    hasError = false;
    errorMessage = "";
    pageTitle = _getPageTitle();
  }

  @action
  void onBack() {
    loading = false;
    if (Modular.get<AuthController>().facebookProfile != null ||
        Modular.get<AuthController>().currentUser != null) {
      switch (page) {
        case 2:
          setPage(0);
          break;
        case 3:
          setPage(1);
          break;
        case 4:
          if (profile.photos != null && profile.photos.length > 0)
            setPage(2);
          else
            setPage(3);
          break;
        case 14:
          break;
        default:
          setPage(page - 1);
          break;
      }
    } else {
      switch (page) {
        case 3:
          setPage(1);
          break;
        case 4:
          if (profile.photos != null && profile.photos.length > 0)
            setPage(2);
          else
            setPage(3);
          break;
        case 14:
          break;
        default:
          setPage(page - 1);
          break;
      }
    }
  }

  String _getPageTitle() {
    if (hasError)
      return "Erro";
    else
      switch (page) {
        case 0:
          return "Meu nome";
        case 1:
          return "Minha senha";
        case 2:
          return "Meu melhor momento";
        case 3:
          return "Fotinha para vida";
        case 4:
          return "Sobre mim";
        case 5:
          return "Meu mapa astral";
        case 6:
          return "Meu mapa astral";
        case 7:
          return "Meu mapa astral";
        case 8:
          return "Eu sou";
        case 9:
          return "Procuro por";
        case 10:
          return "Interesses";
        case 11:
          return "Formas de amar";
        case 12:
          return "Busco";
        case 13:
          return "Ativação de conta";
        case 14:
          return "Ativar localização";
        default:
          return "Cadastro";
      }
  }

  // MARK: Form Validation
  @action
  setValidity(bool value) {
    isButtonDisabled = value;
  }

  @action
  String validateEmail(String text) {
    if (Validators.isValidEmail(text)) {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return 'Email digitado não é válido';
    }
  }

  @action
  String validateName(String text) {
    if (Validators.isValidName(text)) {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return 'Nome deve ter no mínimo três caracteres';
    }
  }

  @action
  String validateBirthDate(String text) {
    var validBirthDate = Validators.isValidBirthDate(text);
    if (validBirthDate == 'valid') {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return validBirthDate;
    }
  }

  String validateBirthHour(String text) {
    if (Validators.isValidBirthHour(text)) {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return "Horário com o formato inválido";
    }
  }

  @action
  String validateAbout(String text) {
    if (Validators.isValidAbout(text)) {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return 'O texto não pode ultrapassar 500 caracteres';
    }
  }

  @action
  String validatePassword(String text) {
    if (Validators.isValidPassword(text)) {
      isButtonDisabled = false;
      return null;
    } else {
      isButtonDisabled = true;
      return 'A senha deve ter de 6 a 30 caracteres';
    }
  }

  @action
  verifySelected(String nameList, List array) {
    final selected = array.where((valuePosition) => valuePosition == nameList);
    return selected.length > 0;
  }

  @action
  addOrRemoveSelected(String nameList, dynamic array, bool validacao) {
    validacao ? array.add(nameList) : array.remove(nameList);
    isButtonDisabled = array.length == 0;
    return array;
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
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
