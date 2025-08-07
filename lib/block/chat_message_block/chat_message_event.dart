import 'package:equatable/equatable.dart';

abstract class ChatMessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch messages from backend
class FetchChatMessages extends ChatMessageEvent {
  final String chatId;

  FetchChatMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

// Send a message
class SendChatMessage extends ChatMessageEvent {
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String fileUrl;

  SendChatMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
    this.messageType = 'text',
    this.fileUrl = '',
  });

  @override
  List<Object?> get props => [chatId, senderId, content, messageType, fileUrl];
}


class InitSocket extends ChatMessageEvent {
  final String userId;
  final String chatId;

  InitSocket({required this.userId, required this.chatId});

  @override
  List<Object?> get props => [userId, chatId];
}

class ReceiveChatMessage extends ChatMessageEvent {
  final Map<String, dynamic> message;

  ReceiveChatMessage(this.message);

  @override
  List<Object?> get props => [message];
}
