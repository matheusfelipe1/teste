import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'config_phone_controller.g.dart';

class ConfigPhoneController = _ConfigPhoneBase with _$ConfigPhoneController;

abstract class _ConfigPhoneBase with Store {
  @observable
  int page = 0;

  @observable
  PageController pageController;

  @observable
  String pageTitle = "";

  @observable
  bool hasError = false;
  
  @observable
  String errorMessage = "";

  @observable
  bool completed = false;

  _ConfigPhoneBase({int initialPage}) {
    if (initialPage != null) page = initialPage;
    _init();
  }

  _init() {
    pageController = PageController(initialPage: page);
    pageTitle = _getPageTitle();
  }

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
    setPage(page - 1);
  }

  String _getPageTitle() {
    if (hasError)
      return "Erro";
    else
      switch (page) {
        case 0:
          return "Configurações";
        case 1:
          return "Confirmação";
        default:
          return "Configurações";
      }
  }
}
