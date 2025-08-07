abstract class ChatEvent {}

class FetchUserChats extends ChatEvent {
  final String userId;
  FetchUserChats(this.userId);
}
