import 'package:json_annotation/json_annotation.dart';

part 'chats_model.g.dart';

@JsonSerializable()
class ChatsModel {
  ChatsModel({
    required this.connections,
    required this.chat,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsModelFromJson(json);
  @JsonKey(name: 'connections')
  List<String> connections;
  @JsonKey(name: 'chat')
  List<Chat> chat;

  Map<String, dynamic> toJson() => _$ChatsModelToJson(this);
}

@JsonSerializable()
class Chat {
  Chat({
    required this.pengirim,
    required this.penerima,
    required this.pesan,
    required this.time,
    required this.isRead,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  @JsonKey(name: 'pengirim')
  String pengirim;
  @JsonKey(name: 'penerima')
  String penerima;
  @JsonKey(name: 'pesan')
  String pesan;
  @JsonKey(name: 'time')
  String time;
  @JsonKey(name: 'isRead')
  bool isRead;

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
