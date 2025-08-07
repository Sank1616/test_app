import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/chat_message_service.dart';
import 'chat_message_event.dart';
import 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatsService chatsService;
  final SocketService socketService = SocketService();

  List<Map<String, dynamic>> _messages = [];

  ChatMessageBloc(this.chatsService) : super(ChatMessageInitial()) {
    on<FetchChatMessages>(_onFetchMessages);
    on<SendChatMessage>(_onSendMessage);
    on<InitSocket>(_onInitSocket);
    on<ReceiveChatMessage>(_onReceiveChatMessage);
  }

  Future<void> _onFetchMessages(
      FetchChatMessages event, Emitter<ChatMessageState> emit) async {
    emit(ChatMessageLoading());
    try {
      final messages = await chatsService.getChatMessages(event.chatId);
      _messages = List<Map<String, dynamic>>.from(messages);
      emit(ChatMessageLoaded(_messages));
    } catch (e) {
      emit(ChatMessageError('Failed to fetch messages'));
    }
  }

  Future<void> _onSendMessage(
      SendChatMessage event, Emitter<ChatMessageState> emit) async {
    emit(ChatMessageSending());
    try {
      final messagePayload = {
        'chatId': event.chatId,
        'senderId': event.senderId,
        'content': event.content,
        'messageType': event.messageType,
        'fileUrl': event.fileUrl,
      };

      // Send via socket
      socketService.sendMessage(messagePayload);

      // Also send via HTTP for persistence
      await chatsService.sendMessage(
        event.chatId,
        event.senderId,
        event.content,
        event.messageType,
        event.fileUrl,
      );

      emit(ChatMessageSent());

      // Optional: Append directly instead of refetching
      _messages.add(messagePayload);
      emit(ChatMessageLoaded(List.from(_messages)));
    } catch (e) {
      emit(ChatMessageError('Failed to send message'));
    }
  }

  Future<void> _onInitSocket(
      InitSocket event, Emitter<ChatMessageState> emit) async {
    socketService.connect(event.userId);

    socketService.onReceiveMessage((data) {
      if (data != null && data['chatId'] == event.chatId) {
        add(ReceiveChatMessage(data));
      }
    });
  }

  Future<void> _onReceiveChatMessage(
      ReceiveChatMessage event, Emitter<ChatMessageState> emit) async {
    _messages.add(event.message);
    emit(ChatMessageLoaded(List.from(_messages)));
  }

  @override
  Future<void> close() {
    socketService.disconnect();
    return super.close();
  }
}
