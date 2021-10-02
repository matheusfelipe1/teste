import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/signup_repository.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';

// Binds
import 'package:joinder_app/app/modules/home/home_controller.dart';

// Pages and Modules
import 'package:joinder_app/app/modules/home/home_page.dart';
import 'package:joinder_app/app/modules/home/profile_detail/profile_detail_page.dart';
import 'package:joinder_app/app/modules/home/waiting_confirm_email/waiting_confirm_email_controller.dart';
import 'package:joinder_app/app/modules/home/waiting_confirm_email/waiting_confirm_email_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => ChatController()),
        Bind((i) => WaitingConfirmEmailController()),
        Bind<ISignUpRepository>((i) => SignUpRepository())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => HomePage()),
        ModularRouter('/profile-detail', child: (_, args) => ProfileDetailPage()),
        ModularRouter('/waiting-confirm',
            child: (_, args) => WaitingConfirmEmailPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
