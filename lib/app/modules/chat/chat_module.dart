import 'package:flutter_modular/flutter_modular.dart';

// Binds
import 'chat_controller.dart';
import 'package:joinder_app/app/modules/chat/repositories/chat_repository.dart';
import 'package:joinder_app/app/modules/chat/repositories/ichat_repository.dart';

// Pages and Modules
import 'package:joinder_app/app/modules/chat/fridge/fridge_page.dart';
import 'chat_detail/chat_detail_page.dart';
import 'chat_message_list_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => ChatMessageListPage()),
        ModularRouter('/detail', child: (_, args) => ChatDetailPage()),
        ModularRouter('/fridge', child: (_, args) => FridgePage()),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
