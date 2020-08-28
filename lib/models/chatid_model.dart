// https://app.quicktype.io/
// To parse this JSON data, do
//
//     final chatid = chatidFromJson(jsonString);

import 'dart:convert';

Chatid chatidFromJson(String str) => Chatid.fromJson(json.decode(str));

String chatidToJson(Chatid data) => json.encode(data.toJson());

class Chatid {
  Chatid({
    this.chats,
  });

  List<Chat> chats;

  factory Chatid.fromJson(Map<String, dynamic> json) => Chatid(
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
