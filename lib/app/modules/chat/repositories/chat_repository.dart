import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:joinder_app/app/shared/models/friege.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'package:joinder_app/app/modules/chat/repositories/ichat_repository.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/custom_http/custom_http.dart';
import 'package:joinder_app/app/shared/models/chat.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

class ChatRepository implements IChatRepository {
  final databaseReference = FirebaseDatabase.instance.reference();
  final referenceKey = "Chat";

  final storageReference = FirebaseStorage.instance.ref();

  final _http = Modular.get<CustomHttp>();
  final _authController = Modular.get<AuthController>();

  @override
  Future<Chat> getChat(String id) async {
    try {
      DataSnapshot map =
          await databaseReference.child(referenceKey).child(id).once();
      if (map.value != null) {
        if (map.value is Map) {
          Chat chat = Chat.fromJson(map.value);
          String profileId = "";
          if (chat.sender != _authController.profile.id) {
            profileId = chat.sender;
          } else {
            profileId = chat.recipient;
          }
          final profile = (await getProfiles([profileId])).first;
          chat.profile = profile;
          return chat;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Chat>> getChats() async {
    try {
      List<Chat> chats = new List<Chat>();
      List<String> profileIds = new List<String>();
      DataSnapshot recipient = await databaseReference
          .child(referenceKey)
          .orderByChild("recipient")
          .equalTo(_authController.profile.id)
          .once();
      DataSnapshot sender = await databaseReference
          .child(referenceKey)
          .orderByChild("sender")
          .equalTo(_authController.profile.id)
          .once();
      if (recipient.value != null) {
        if (recipient.value is Map) {
          Map list = recipient.value;
          for (var item in list.values) {
            if (item != null) {
              Chat chat = Chat.fromJson(item);
              if (chat.delete
                          .where((d) => d == _authController.profile.id)
                          .length ==
                      0 &&
                  chat.fridge
                          .where((f) => f == _authController.profile.id)
                          .length ==
                      0) {
                chats.add(chat);
                profileIds.add(chat.sender);
              }
            }
          }
        }
      }
      if (sender.value != null) {
        if (sender.value is Map) {
          Map list = sender.value;
          for (var item in list.values) {
            if (item != null) {
              Chat chat = Chat.fromJson(item);
              if (chat.delete
                          .where((d) => d == _authController.profile.id)
                          .length ==
                      0 &&
                  chat.fridge
                          .where((f) => f == _authController.profile.id)
                          .length ==
                      0 &&
                  chat.messages.length > 0) {
                chats.add(chat);
                profileIds.add(chat.recipient);
              }
            }
          }
        }
      }
      // Fill Profiles
      final profiles = await getProfiles(profileIds);
      List<Chat> chatListFinal = new List<Chat>();

      for(var profile in profiles){
        Chat chat = chats.firstWhere((c) => c.sender == profile.id || c.recipient == profile.id);
        chatListFinal.add(chat);

      }

      for (var item in chatListFinal) {
        if (item.recipient == _authController.profile.id) {
          item.profile = profiles.firstWhere((p) => p.id == item.sender);
        } else {
          item.profile = profiles.firstWhere((p) => p.id == item.recipient);
        }
      }
      chatListFinal.sort(
          (a, b) => DateTime.parse(a.messages.length == 0 ? a.date : a.messages.last.date).compareTo(DateTime.parse(a.messages.length == 0 ? a.date : a.messages.last.date)));
      return chatListFinal.reversed.toList();
    } catch (e) {
      return new List<Chat>();
    }
  }

  @override
  Future<List<Fridge>> getFridgeChats() async {
    List<Fridge> listFridge = [];

    try {
      var now = new DateTime.now();
      Response result = await _http.client.get('/profiles/fridge?cache=${now}');
      var resultData = result.data['results'];

      if (resultData != null && resultData is List) {
        for (var item in resultData)
          if (item is Map) {
            Fridge fridge = Fridge.fromJson(item);
            listFridge.add(fridge);
          }
      }
      return listFridge;
    } catch (e) {
      return listFridge = [];
    }
  }

  Future<List<Profile>> getProfiles(List<String> profileIds) async {
    try {
      final map = {"profiles": profileIds};
      Response result =
          await _http.client.post('/chats/', data: json.encode(map));
      List<Profile> profiles = new List<Profile>();
      if (result.data['results'] != null && result.data['results'] is List) {
        if (result.data['results'][0] is List) {
          for (var item in result.data['results'][0]) {
            Profile profile = Profile.fromJson(item);
            profiles.add(profile);
          }
        }
      }
      return profiles;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> deleteChat(Chat chat) {
    if (chat.delete.where((d) => d == _authController.profile.id).length == 0) {
      chat.delete.add(_authController.profile.id);
    }
    return Future.wait([
      databaseReference.child(referenceKey).child(chat.id).update({
        'delete': chat.delete,
      }),
    ]);
  }

  @override
  Future<void> addMessage(Chat chat, String type, String value) {
    String key =
        databaseReference.child(referenceKey).child(chat.id).push().key;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return Future.wait([
      databaseReference
          .child(referenceKey)
          .child(chat.id)
          .child("messages")
          .child(key)
          .set({
        'date': formatter.format(DateTime.now().toUtc()),
        'sender': _authController.profile.id,
        'type': type,
        'value': value,
      }),
    ]);
  }

  @override
  Future<void> addToFridge(String idProfile) async {
    try {
      final map = {"profile_id": idProfile};
      await _http.client.post('/profiles/fridge', data: json.encode(map));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteFromFridge(String idProfile) async {
    try {
      final map = {"profile_id": idProfile};
      await _http.client.delete('/profiles/fridge', data: json.encode(map));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> uploadChatImage(File file, Chat chat) async {
    try {
      String uidImg = Uuid().v1();
      final node =
          storageReference.child(referenceKey).child(chat.id).child('$uidImg');
      StorageUploadTask uploadTask = node.putFile(file);
      await uploadTask.onComplete;
      return await node.getDownloadURL();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> createChat(String person) async {
    try {
      DataSnapshot recipient = await databaseReference
          .child(referenceKey)
          .orderByChild("recipient")
          .equalTo(person)
          .once();
      DataSnapshot sender = await databaseReference
          .child(referenceKey)
          .orderByChild("sender")
          .equalTo(person)
          .once();

      if (recipient.value != null) {
        if (recipient.value is Map) {
          Map list = recipient.value;
          for (var item in list.values) {
            Chat chat = Chat.fromJson(item);
            if (chat.sender == _authController.profile.id) return chat.id;
          }
        }
      }
      if (sender.value != null) {
        if (sender.value is Map) {
          Map list = sender.value;
          for (var item in list.values) {
            Chat chat = Chat.fromJson(item);
            if (chat.recipient == _authController.profile.id) return chat.id;
          }
        }
      }

      String key = databaseReference.child(referenceKey).push().key;
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
      databaseReference.child(referenceKey).child(key).set({
        'date': formatter.format(DateTime.now().toUtc()),
        'sender': _authController.profile.id,
        'recipient': person,
        'id': key,
      });

      return key;
    } catch (e) {
      return "";
    }
  }

  @override
  Future<int> reportUser(String idProfile, String type, String message) async {
    try {
      var arr = message.split(': ');
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["type"] = type;
      map["type_reason"] = arr[0];
      map["message"] = arr.length > 1 ? arr[1] : "";
      Response result = await _http.client
          .post('/profiles/${idProfile}/report', data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<Profile> getProfile(String id) async {
    try {
      final result = await _http.client.get('/profiles/${id}');
      final json = result.data;
      if (json is Map) {
        if (json['results'] is List)
          return new Profile.fromJson(json['results'][0]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
