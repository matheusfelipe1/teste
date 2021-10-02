import 'dart:io';

import 'package:joinder_app/app/shared/models/chat.dart';
import 'package:joinder_app/app/shared/models/friege.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

abstract class IChatRepository {
  Future<Chat> getChat(String id);
  Future<List<Chat>> getChats();
  Future<List<Fridge>> getFridgeChats();
  Future<void> deleteChat(Chat chat);
  Future<void> addMessage(Chat chat, String type, String value);
  Future<void> addToFridge(String idProfile);
  Future<void> deleteFromFridge(String idProfile);
  Future<String> createChat(String person);
  Future<int> reportUser(String idProfile, String type, String message);
  Future<String> uploadChatImage(File file, Chat chat);
  Future<Profile> getProfile(String id);
}
