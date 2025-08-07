abstract class ChatMessageState {}

class ChatMessageInitial extends ChatMessageState {}

class ChatMessageLoading extends ChatMessageState {}

class ChatMessageLoaded extends ChatMessageState {
  final List messages;

  ChatMessageLoaded(this.messages);
}

class ChatMessageError extends ChatMessageState {
  final String message;

  ChatMessageError(this.message);
}

class ChatMessageSending extends ChatMessageState {}

class ChatMessageSent extends ChatMessageState {}
