// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      keyName: json['keyName'] as String?,
      email: json['email'] as String?,
      creationTime: json['creation_time'] as String?,
      lastSignInTime: json['last_sign_in_time'] as String?,
      photoUrl: json['photo_url'] as String?,
      status: json['status'] as String?,
      updatedTime: json['updated_time'] as String?,
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'keyName': instance.keyName,
      'email': instance.email,
      'creation_time': instance.creationTime,
      'last_sign_in_time': instance.lastSignInTime,
      'photo_url': instance.photoUrl,
      'status': instance.status,
      'updated_time': instance.updatedTime,
      'chats': instance.chats,
    };

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      connection: json['connection'] as String?,
      chatId: json['chat_id'] as String?,
      lastTime: json['last_time'] as String?,
      totalUnread: json['total_unread'] as int?,
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'connection': instance.connection,
      'chat_id': instance.chatId,
      'last_time': instance.lastTime,
      'total_unread': instance.totalUnread,
    };
