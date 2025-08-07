import '../../data/models/chat_response_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chats;
  ChatLoaded(this.chats);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
