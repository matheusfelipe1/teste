import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/custom_http/interceptors.dart';
import 'package:dio/dio.dart';

import 'package:joinder_app/app/shared/util/constants.dart';

class CustomHttp {
  final Dio client = Dio();
  CustomHttp() {
    client.options.baseUrl = BASE_URL;
    client.interceptors.add(CustomInterceptors());
    client.options.connectTimeout = 60000;
  }
}
