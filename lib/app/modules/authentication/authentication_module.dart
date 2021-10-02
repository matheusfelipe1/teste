import 'package:flutter_modular/flutter_modular.dart';

// Binds
import 'package:joinder_app/app/modules/authentication/authentication_controller.dart';
import 'package:joinder_app/app/modules/authentication/entrar/entrar_controller.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_controller.dart';
import 'package:joinder_app/app/modules/authentication/login/login_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/signup_repository.dart';

// Pages and Modules
import 'package:joinder_app/app/modules/authentication/phone_auth/phone_auth_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/signup_page.dart';
import 'package:joinder_app/app/modules/authentication/login/login_page.dart';
import 'package:joinder_app/app/modules/authentication/forgot_password/forgot_password_page.dart';
import 'package:joinder_app/app/modules/authentication/phone_auth/phone_auth_page.dart';
import 'package:joinder_app/app/modules/authentication/active_account/active_account_page.dart';

import 'entrar/entrar_page.dart';

class AuthenticationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EntrarController()),
        Bind((i) => ForgotPasswordController()),
        Bind((i) => SignUpController()),
        Bind((i) => LoginController()),
        Bind((i) => PhoneAuthController()),
        Bind((i) => AuthenticationController()),
        Bind<ISignUpRepository>((i) => SignUpRepository())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/phone-auth', child: (_, args) => PhoneAuthPage()),
        ModularRouter('/sign-up', child: (_, args) => SignUpPage()),
        ModularRouter('/forgot-password', child: (_, args) => ForgotPasswordPage()),
        ModularRouter('/active-account', child: (_, args) => ActiveAccountPage()),
        ModularRouter('/entrar', child: (_, args) => EntrarPage()),
      ];

  static Inject get to => Inject<AuthenticationModule>.of();
}
