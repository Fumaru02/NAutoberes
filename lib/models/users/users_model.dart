import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable()
class UsersModel {
  UsersModel({
    this.uid,
    this.name,
    this.keyName,
    this.email,
    this.creationTime,
    this.lastSignInTime,
    this.photoUrl,
    this.status,
    this.updatedTime,
    this.chats,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);
  @JsonKey(name: 'uid')
  String? uid;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'keyName')
  String? keyName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'creation_time')
  String? creationTime;
  @JsonKey(name: 'last_sign_in_time')
  String? lastSignInTime;
  @JsonKey(name: 'photo_url')
  String? photoUrl;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'updated_time')
  String? updatedTime;
  @JsonKey(name: 'chats')
  List<ChatUser>? chats;

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}

@JsonSerializable()
class ChatUser {
  ChatUser({
    this.connection,
    this.chatId,
    this.lastTime,
    this.totalUnread,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
  @JsonKey(name: 'connection')
  String? connection;
  @JsonKey(name: 'chat_id')
  String? chatId;
  @JsonKey(name: 'last_time')
  String? lastTime;
  @JsonKey(name: 'total_unread')
  int? totalUnread;

  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
