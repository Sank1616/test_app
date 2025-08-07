import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/utils/constants.dart';
import '../../block/chat_block/chat_block.dart';
import '../../block/chat_block/chat_event.dart';
import '../../block/chat_block/chat_state.dart';
import '../../block/chat_message_block/chat_message_block.dart';
import '../../data/services/chat_message_service.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chats_view/chats_detaile_view.dart';

class VendorHomeView extends StatelessWidget {
  final String userId;

  const VendorHomeView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text(
          'Chats'.toUpperCase(),
          style: TextStyle(
            color: appDefaultColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => ChatBloc(ChatRepository())..add(FetchUserChats(userId)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return _buildLoadingState();
            } else if (state is ChatLoaded) {
              return _buildChatList(state.chats, context);
            } else if (state is ChatError) {
              return _buildErrorState(state.message);
            }
            return _buildEmptyState();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading conversations...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(List chats, BuildContext context) {
    if (chats.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChatBloc>().add(FetchUserChats(userId));
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: chats.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 72,
          endIndent: 16,
          color: Colors.grey[200],
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return _buildChatTile(chat, context);
        },
      ),
    );
  }

  Widget _buildChatTile(dynamic chat, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          child: Text(
            (chat.participants?.first.name ?? 'U')[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: appDefaultColor,
            ),
          ),
        ),
        title: Text(
          chat.participants?.first.name ?? 'Unknown User',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: appDefaultColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              const Icon(
                Icons.message_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                chat.lastMessage?.content ?? 'No messages yet',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  height: 0.6,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatTime(_getTimestamp(chat)),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if (_getUnreadCount(chat) > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${_getUnreadCount(chat)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          final chatId = chat.chatId;
          if (chatId != null) {
            print('Tapped on chat: $chatId');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => ChatMessageBloc(ChatsService()),
                  child: ChatDetailView(
                    chatId: chatId,
                    senderId: userId,
                  ),
                ),
              ),
            );
          } else {
            print('Error: Chat ID is null');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to open chat - invalid chat ID'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Start a conversation to see your messages here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.add_comment),
            label: const Text('Start New Chat'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? timestamp) {
    if (timestamp == null) return '';
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inDays > 0) return '${difference.inDays}d';
    if (difference.inHours > 0) return '${difference.inHours}h';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m';
    return 'now';
  }

  DateTime? _getTimestamp(dynamic chat) {
    try {
      if (chat.lastMessage != null) {
        if (chat.lastMessage.timestamp != null) {
          return chat.lastMessage.timestamp;
        }
        if (chat.lastMessage.createdAt != null) {
          return chat.lastMessage.createdAt;
        }
        if (chat.lastMessage.date != null) return chat.lastMessage.date;
      }
      if (chat.timestamp != null) return chat.timestamp;
      if (chat.createdAt != null) return chat.createdAt;
      if (chat.updatedAt != null) return chat.updatedAt;
    } catch (e) {
      print('Error accessing timestamp: $e');
    }
    return null;
  }

  int _getUnreadCount(dynamic chat) {
    try {
      if (chat.unreadCount != null) return chat.unreadCount;
      if (chat.unread_count != null) return chat.unread_count;
      if (chat.unreadMessages != null) return chat.unreadMessages;
    } catch (e) {
      print('Error accessing unread count: $e');
    }
    return 0;
  }
}
