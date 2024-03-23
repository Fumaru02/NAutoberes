// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsModel _$ChatsModelFromJson(Map<String, dynamic> json) => ChatsModel(
      connections: (json['connections'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      chat: (json['chat'] as List<dynamic>)
          .map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatsModelToJson(ChatsModel instance) =>
    <String, dynamic>{
      'connections': instance.connections,
      'chat': instance.chat,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      pengirim: json['pengirim'] as String,
      penerima: json['penerima'] as String,
      pesan: json['pesan'] as String,
      time: json['time'] as String,
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'pengirim': instance.pengirim,
      'penerima': instance.penerima,
      'pesan': instance.pesan,
      'time': instance.time,
      'isRead': instance.isRead,
    };
