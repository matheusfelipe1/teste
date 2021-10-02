import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joinder_app/app/modules/home/home_controller.dart';
import 'package:joinder_app/app/modules/home/repositories/ihome_repository.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/models/card_model.dart';
import 'package:joinder_app/app/shared/models/friege.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:image_picker/image_picker.dart';

import 'package:joinder_app/app/modules/chat/repositories/ichat_repository.dart';

import 'package:joinder_app/app/shared/models/chat.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatBase with _$ChatController;

abstract class _ChatBase with Store {
  final IChatRepository _chatRepository = Modular.get();
  final IHomeRepository _homeRepository = Modular.get();
  final _authController = Modular.get<AuthController>();
  final _homeController = Modular.get<HomeController>();
  final databaseReference = FirebaseDatabase.instance.reference();
  final chatReferenceKey = "Evento";

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Chat> chats;

  @observable
  Chat selectedChat;

  @observable
  ObservableList<Fridge> fridge;

  @observable
  ObservableList<dynamic> fridgeMarks;

  @observable
  bool isUploading = false;

  @observable
  bool hasUploadError = false;

  @observable
  String uploadErrorMessage = "";

  _ChatBase() {
    _init();
  }

  _init() {}

  @action
  getChats() async {
    isLoading = true;
    chats = ObservableList<Chat>.of(await _chatRepository.getChats());
    isLoading = false;
  }

  @action
  createChat(String person) async {
    isLoading = true;
    final result = await _chatRepository.createChat(person);
    _authController.currentChat = result;
    Modular.to.pushNamed('/chat/detail');
    selectedChat = await _chatRepository.getChat(_authController.currentChat);
    if (selectedChat == null) Modular.to.pop();
    if (selectedChat.profile.photos.length == 0)
      selectedChat.profile.photos
          .add(AppUtils.getSignImage(selectedChat.profile));
    observeUniqueChat();
    _homeController.isButtonDisabled = false;
    isLoading = false;
  }

  @action
  getChat(String id) async {
    isLoading = true;
    _authController.currentChat = id;
    Modular.to.pushNamed('chat/detail').then((value) => {chats = chats});
    selectedChat = await _chatRepository.getChat(_authController.currentChat);
    if (selectedChat == null) Modular.to.pop();
    observeUniqueChat();
    isLoading = false;
  }

  @action
  getFridgeChats() async {
    isLoading = true;
    fridge = ObservableList<Fridge>.of(await _chatRepository.getFridgeChats());
    fridgeMarks = new ObservableList<dynamic>();
    for (var item in fridge) {
      fridgeMarks.add({'id': item.id, 'marked': false});
    }
    isLoading = false;
  }

  @action
  deleteFridgeChats() async {
    ObservableList<dynamic> fridgeMarksDeleted = new ObservableList<dynamic>();
    for (var item in fridgeMarks) {
      if (item['marked']) {
        _chatRepository
            .deleteFromFridge(fridge.firstWhere((f) => f.id == item['id']).id);
        fridge.removeWhere((f) => f.id == item['id']);
        fridgeMarksDeleted.add(item);
      }
    }
    for (var item in fridgeMarksDeleted) {
      fridgeMarks.remove(item);
    }
    getChats();
    _homeController.fillCards(false, false);
  }

  @action
  deleteChat(int index) async {
    _chatRepository.deleteChat(chats[index]);
    chats.remove(chats[index]);
  }

  @action
  addToFridge(BuildContext context, String desc) async {
    await _chatRepository.addToFridge(selectedChat.profile.id);
    chats.removeWhere((c) => c.id == selectedChat.id);
    getChats();
    _homeController.fillCards(false, false);
    _chatRepository.reportUser(selectedChat.profile.id, 'FREEZE', desc);

    await AppUtils.defaultDialogChat(
      context,
      "OK. VOCÊ ACABA DE DAR\n UM GELO EM",
      selectedChat.profile.name,
      true,
      true,
      'assets/images/ice.png',
      'O usuário ficará na geladeira \ndurante o tempo que você achar \nnecessário!',
      true,
      buttonText: "OK",
    );
    Modular.to.pop();
  }

  @action
  reportUser(BuildContext context, String desc) async {
    final result = await _chatRepository.reportUser(
        selectedChat.profile.id, 'REPORT', desc);
    switch (result) {
      case 200:
        await AppUtils.defaultDialogChat(
          context,
          "VOCÊ ACABA DE FAZER\n UMA DENÚNCIA",
          "DENUNCIAR",
          true,
          false,
          'assets/images/ic_denunciar_topo.png',
          'Agradecemos pela sua atitude. \nQueremos que você sinta\n segurança e acolhimento.',
          true,
          buttonText: "OK",
        );
        break;
      default:
        _authController.showSnackbar(
            context, 'error', 'Ups... \n Erro ao reportar esse usuário :(');
        break;
    }
  }

  @action
  addMessageToChat(String value) async {
    await _chatRepository.addMessage(selectedChat, 'message', value);
  }

  @action
  uploadPhoto(ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: source);
      var lengthImage = image.lengthSync();
      if (lengthImage <= 1000000) {
        if (image != null) {
          isUploading = true;
          final connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult != ConnectivityResult.none) {
            String url =
                await _chatRepository.uploadChatImage(image, selectedChat);
            if (url != null && url != "") {
              isUploading = false;
              await _chatRepository.addMessage(selectedChat, 'image', url);
            } else {
              isUploading = false;
              hasUploadError = true;
              uploadErrorMessage = "Erro ao carregar sua foto :(";
            }
          } else {
            isUploading = false;
            hasUploadError = true;
            uploadErrorMessage = "Falha ao conectar ao servidor :(";
          }
        }
      } else {
        hasUploadError = true;
        uploadErrorMessage = "Foto muito grande, tamanho máximo 1MB :(";
      }
    } catch (e) {
      isUploading = false;
      hasUploadError = true;
      uploadErrorMessage = "Erro ao carregar sua foto :(";
    }
  }

  @action
  observeChats() {
    databaseReference
        .child("Chat")
        .orderByChild("recipient")
        .equalTo(_authController.profile.id)
        .onChildAdded
        .listen((data) {
      final chat = Chat.fromJson(data.snapshot.value);
      final index = chats.indexWhere((c) => c.id == chat.id);
      final profile = chats[index].profile;
      chats[index] = chat;
      chats[index].profile = profile;
    });
    databaseReference
        .child("Chat")
        .orderByChild("sender")
        .equalTo(_authController.profile.id)
        .onChildAdded
        .listen((data) {
      final chat = Chat.fromJson(data.snapshot.value);
      final index = chats.indexWhere((c) => c.id == chat.id);
      final profile = chats[index].profile;
      chats[index] = chat;
      chats[index].profile = profile;
    });
  }

  @action
  observeUniqueChat() {
    databaseReference
        .child("Chat")
        .child(_authController.currentChat)
        .child("messages")
        .onChildAdded
        .listen((data) {
      print(data);
      final message = Message.fromJson(data.snapshot.value);
      message.id = data.snapshot.key;
      if (selectedChat.messages.where((c) => c.id == message.id).length == 0)
        selectedChat.messages.add(message);
    });
  }

  @action
  redirectProfileDetail(Profile chatDetail) async {
    try {
      CardModel cardDetail = new CardModel();
      for (var item in _homeController.cards) {
        if (item.id == chatDetail.id) {
          cardDetail = item;
        }
      }
      if (cardDetail.id == null) {
        cardDetail = await _homeRepository.getCard(chatDetail.id);
      }
      _homeController.fillCardProfile(cardDetail);
    } catch (e) {
      return null;
    }
  }
}
