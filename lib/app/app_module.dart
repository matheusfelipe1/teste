import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/app_widget.dart';
import 'package:joinder_app/app/modules/chat/chat_module.dart';

// Binds
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/custom_http/custom_http.dart';
import 'package:joinder_app/app/shared/auth/repositories/iauth_repository.dart';
import 'package:joinder_app/app/shared/auth/repositories/auth_repository.dart';

// Pages and Modules
import 'package:joinder_app/app/modules/home/home_module.dart';
import 'package:joinder_app/app/modules/profile/profile_module.dart';
import 'package:joinder_app/app/modules/authentication/authentication_module.dart';

import 'package:joinder_app/app/splash/splash_page.dart';

import 'modules/chat/chat_controller.dart';
import 'modules/chat/repositories/chat_repository.dart';
import 'modules/chat/repositories/ichat_repository.dart';
import 'modules/home/repositories/home_repository.dart';
import 'modules/home/repositories/ihome_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthController()),
        Bind((i) => CustomHttp()),
        Bind<IAuthRepository>((i) => AuthRepository()),
        Bind((i) => ChatController()),
        Bind<IChatRepository>((i) => ChatRepository()),
        Bind<IHomeRepository>((i) => HomeRepository())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => SplashPage()),
        ModularRouter('/home',
            module: HomeModule(), transition: TransitionType.defaultTransition),
        ModularRouter('/profile',
            module: ProfileModule(),
            transition: TransitionType.defaultTransition),
        ModularRouter('/auth',
            module: AuthenticationModule(),
            transition: TransitionType.defaultTransition),
        ModularRouter('/chat',
            module: ChatModule(), transition: TransitionType.defaultTransition),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
