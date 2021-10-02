import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

import 'package:joinder_app/app/shared/enums/auth_status.dart';
import 'package:joinder_app/app/shared/models/error/error_feedback.dart';

class CustomInterceptors extends InterceptorsWrapper {
  
  @override
  Future onRequest(RequestOptions options) async {
    final _authController = Modular.get<AuthController>();
    if(_authController.status == AuthStatus.logged) {
      final token = await _authController.getToken();
      
      if(token != null && token != "")
        if(options.method == "GET")
          options.headers = {'Authorization': 'Bearer $token'};
        else
          options.headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      else
          options.headers = {'Content-Type': 'application/json'};
    }
    return options;
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }

  @override
  Future onError(DioError err) async {
    if (err.response == null || err.error == DioErrorType.CONNECT_TIMEOUT) {
      err.response = Response(data: new ErrorFeedback(code: "timeout", message: "Favor verificar sua conexão."));
    } else if(err.error == DioErrorType.RESPONSE) {
      switch (err.response.statusCode) {
        case 401:
          err.response = Response(data: new ErrorFeedback(code: "unauthorized", message: "Requisição não autorizada."));
          break;
        case 404:
          err.response = Response(data: new ErrorFeedback(code: "notfound", message: "Not Found."));
          break;
        case 409:
          err.response = Response(data: new ErrorFeedback(code: "conflict", message: "Já existe um objeto para a requisição feita."));
          break;
        case 500:
          err.response = Response(data: new ErrorFeedback(code: "internal", message: "Erro no servidor."));
          break;
        default:
          err.response = Response(data: new ErrorFeedback(code: "none", message: "Algo deu errado."));
          break;
      }
    }
    return err;
  }
}
