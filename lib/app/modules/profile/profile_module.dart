import 'package:flutter_modular/flutter_modular.dart';

// Binds
import 'package:joinder_app/app/modules/profile/profile_controller.dart';
import 'package:joinder_app/app/modules/profile/config_phone/config_phone_controller.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/signup_repository.dart';


// Pages and Modules
import 'package:joinder_app/app/modules/profile/profile_edit/profile_edit.dart';
import 'package:joinder_app/app/modules/profile/profile_config/profile_config_page.dart';
import 'package:joinder_app/app/modules/profile/config_phone/config_phone_page.dart';
import 'package:joinder_app/app/modules/profile/config_email/config_email_page.dart';
import 'package:joinder_app/app/modules/profile/config_filters/config_filters_page.dart';
import 'package:joinder_app/app/modules/profile/profile_page.dart';
import 'package:joinder_app/app/modules/profile/config_looking_gender/config_looking_gender_page.dart';
import 'package:joinder_app/app/modules/profile/config_privacy_polices/config_privacy_polices_page.dart';
import 'package:joinder_app/app/modules/profile/config_service_terms/config_service_terms_page.dart';

import 'config_feedback/config_feedback_page.dart';

class ProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConfigPhoneController()),
        Bind((i) => ProfileController()),
        Bind<ISignUpRepository>((i) => SignUpRepository())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => ProfilePage()),
        ModularRouter('/edit', child: (_, args) => ProfileEditPage()),
        ModularRouter('/config', child: (_, args) => ProfileConfigPage()),
        ModularRouter('/config/phone', child: (_, args) => ConfigPhonePage()),
        ModularRouter('/config/email', child: (_, args) => ConfigEmailPage()),
        ModularRouter('/config/filters', child: (_, args) => ConfigFiltersPage()),
        ModularRouter('/config/gender', child: (_, args) => ConfigLookingGenderPage()),
        ModularRouter('/config/service', child: (_, args) => ConfigServiceTermsPage()),
        ModularRouter('/config/politics',
            child: (_, args) => ConfigPrivacyPolicesPage()),
        ModularRouter('/config/feedback',
            child: (_, args) => ConfigFeedbackPage()),
      ];

  static Inject get to => Inject<ProfileModule>.of();
}
