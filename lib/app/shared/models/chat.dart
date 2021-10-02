import 'package:intl/intl.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:mobx/mobx.dart';

class Chat {
  String id;
  String date;
  String recipient;
  String sender;
  Profile profile;
  List<String> fridge;
  List<String> delete;
  ObservableList<Message> messages;
  
  Chat({this.id, this.date, this.recipient, this.sender, this.profile, this.messages});

  Chat.fromJson(Map json) {
    id = json['id'];
    date = json['date'];
    recipient = json['recipient'];
    sender = json['sender'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;

    var listFridge = json['fridge'];
    this.fridge = new List<String>();
    if (listFridge is List) {
      for (var item in listFridge) {
        if (item != null) this.fridge.add(item);
      }
    }
    
    var listDelete = json['delete'];
    this.delete = new List<String>();
    if (listDelete is List) {
      for (var item in listDelete) {
        if (item != null) this.delete.add(item);
      }
    }
    
    var listMessages = json['messages'];
    this.messages = new ObservableList<Message>();
    if (listMessages is Map) {
      listMessages.forEach((key, value) {
        listMessages[key]['id'] = key;
      });
      for (var item in listMessages.values.toList()) {
        if (item != null) this.messages.add(Message.fromJson(item));
      }
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
      this.messages.sort((a, b) => format.parse(a.date).compareTo(format.parse(b.date)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['recipient'] = this.recipient;
    data['sender'] = this.sender;
    data['profile'] = this.profile.toJson();
    data['messages'] = this.messages;
    return data;
  }
}

class Message {
  String id;
  String date;
  String type;
  String sender;
  String value;
  
  Message({this.id, this.date, this.type, this.sender, this.value});

  Message.fromJson(Map json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    sender = json['sender'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['type'] = this.type;
    data['sender'] = this.sender;
    data['value'] = this.value;
    return data;
  }
}