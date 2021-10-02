// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatBase, Store {
  final _$isLoadingAtom = Atom(name: '_ChatBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$chatsAtom = Atom(name: '_ChatBase.chats');

  @override
  ObservableList<Chat> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<Chat> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  final _$selectedChatAtom = Atom(name: '_ChatBase.selectedChat');

  @override
  Chat get selectedChat {
    _$selectedChatAtom.reportRead();
    return super.selectedChat;
  }

  @override
  set selectedChat(Chat value) {
    _$selectedChatAtom.reportWrite(value, super.selectedChat, () {
      super.selectedChat = value;
    });
  }

  final _$fridgeAtom = Atom(name: '_ChatBase.fridge');

  @override
  ObservableList<Fridge> get fridge {
    _$fridgeAtom.reportRead();
    return super.fridge;
  }

  @override
  set fridge(ObservableList<Fridge> value) {
    _$fridgeAtom.reportWrite(value, super.fridge, () {
      super.fridge = value;
    });
  }

  final _$fridgeMarksAtom = Atom(name: '_ChatBase.fridgeMarks');

  @override
  ObservableList<dynamic> get fridgeMarks {
    _$fridgeMarksAtom.reportRead();
    return super.fridgeMarks;
  }

  @override
  set fridgeMarks(ObservableList<dynamic> value) {
    _$fridgeMarksAtom.reportWrite(value, super.fridgeMarks, () {
      super.fridgeMarks = value;
    });
  }

  final _$isUploadingAtom = Atom(name: '_ChatBase.isUploading');

  @override
  bool get isUploading {
    _$isUploadingAtom.reportRead();
    return super.isUploading;
  }

  @override
  set isUploading(bool value) {
    _$isUploadingAtom.reportWrite(value, super.isUploading, () {
      super.isUploading = value;
    });
  }

  final _$hasUploadErrorAtom = Atom(name: '_ChatBase.hasUploadError');

  @override
  bool get hasUploadError {
    _$hasUploadErrorAtom.reportRead();
    return super.hasUploadError;
  }

  @override
  set hasUploadError(bool value) {
    _$hasUploadErrorAtom.reportWrite(value, super.hasUploadError, () {
      super.hasUploadError = value;
    });
  }

  final _$uploadErrorMessageAtom = Atom(name: '_ChatBase.uploadErrorMessage');

  @override
  String get uploadErrorMessage {
    _$uploadErrorMessageAtom.reportRead();
    return super.uploadErrorMessage;
  }

  @override
  set uploadErrorMessage(String value) {
    _$uploadErrorMessageAtom.reportWrite(value, super.uploadErrorMessage, () {
      super.uploadErrorMessage = value;
    });
  }

  final _$getChatsAsyncAction = AsyncAction('_ChatBase.getChats');

  @override
  Future getChats() {
    return _$getChatsAsyncAction.run(() => super.getChats());
  }

  final _$createChatAsyncAction = AsyncAction('_ChatBase.createChat');

  @override
  Future createChat(String person) {
    return _$createChatAsyncAction.run(() => super.createChat(person));
  }

  final _$getChatAsyncAction = AsyncAction('_ChatBase.getChat');

  @override
  Future getChat(String id) {
    return _$getChatAsyncAction.run(() => super.getChat(id));
  }

  final _$getFridgeChatsAsyncAction = AsyncAction('_ChatBase.getFridgeChats');

  @override
  Future getFridgeChats() {
    return _$getFridgeChatsAsyncAction.run(() => super.getFridgeChats());
  }

  final _$deleteFridgeChatsAsyncAction =
      AsyncAction('_ChatBase.deleteFridgeChats');

  @override
  Future deleteFridgeChats() {
    return _$deleteFridgeChatsAsyncAction.run(() => super.deleteFridgeChats());
  }

  final _$deleteChatAsyncAction = AsyncAction('_ChatBase.deleteChat');

  @override
  Future deleteChat(int index) {
    return _$deleteChatAsyncAction.run(() => super.deleteChat(index));
  }

  final _$addToFridgeAsyncAction = AsyncAction('_ChatBase.addToFridge');

  @override
  Future addToFridge(BuildContext context, String desc) {
    return _$addToFridgeAsyncAction.run(() => super.addToFridge(context, desc));
  }

  final _$reportUserAsyncAction = AsyncAction('_ChatBase.reportUser');

  @override
  Future reportUser(BuildContext context, String desc) {
    return _$reportUserAsyncAction.run(() => super.reportUser(context, desc));
  }

  final _$addMessageToChatAsyncAction =
      AsyncAction('_ChatBase.addMessageToChat');

  @override
  Future addMessageToChat(String value) {
    return _$addMessageToChatAsyncAction
        .run(() => super.addMessageToChat(value));
  }

  final _$uploadPhotoAsyncAction = AsyncAction('_ChatBase.uploadPhoto');

  @override
  Future uploadPhoto(ImageSource source) {
    return _$uploadPhotoAsyncAction.run(() => super.uploadPhoto(source));
  }

  final _$redirectProfileDetailAsyncAction =
      AsyncAction('_ChatBase.redirectProfileDetail');

  @override
  Future redirectProfileDetail(Profile chatDetail) {
    return _$redirectProfileDetailAsyncAction
        .run(() => super.redirectProfileDetail(chatDetail));
  }

  final _$_ChatBaseActionController = ActionController(name: '_ChatBase');

  @override
  dynamic observeChats() {
    final _$actionInfo =
        _$_ChatBaseActionController.startAction(name: '_ChatBase.observeChats');
    try {
      return super.observeChats();
    } finally {
      _$_ChatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic observeUniqueChat() {
    final _$actionInfo = _$_ChatBaseActionController.startAction(
        name: '_ChatBase.observeUniqueChat');
    try {
      return super.observeUniqueChat();
    } finally {
      _$_ChatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
chats: ${chats},
selectedChat: ${selectedChat},
fridge: ${fridge},
fridgeMarks: ${fridgeMarks},
isUploading: ${isUploading},
hasUploadError: ${hasUploadError},
uploadErrorMessage: ${uploadErrorMessage}
    ''';
  }
}
