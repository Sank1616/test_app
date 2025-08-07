import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/utils/constants.dart';
import '../../../block/chat_message_block/chat_message_block.dart';
import '../../../block/chat_message_block/chat_message_event.dart';
import '../../../block/chat_message_block/chat_message_state.dart';

class ChatDetailView extends StatefulWidget {
  final String chatId;
  final String senderId;

  const ChatDetailView({
    super.key,
    required this.chatId,
    required this.senderId,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize socket and fetch existing messages
    final bloc = context.read<ChatMessageBloc>();
    bloc.add(FetchChatMessages(widget.chatId));
    bloc.add(InitSocket(userId: widget.senderId, chatId: widget.chatId));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    context.read<ChatMessageBloc>().add(
      SendChatMessage(
        chatId: widget.chatId,
        senderId: widget.senderId,
        content: content,
      ),
    );
    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessagesList(List messages) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('No messages yet',
                style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text('Start the conversation!',
                style: TextStyle(fontSize: 14, color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        final isMe = message['senderId']?.toString() == widget.senderId;
        return _buildMessageBubble(message, isMe);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isMe) {
    final content = message['content']?.toString() ?? '';
    final timestamp = message['createdAt'] ?? message['sentAt'];
    final status = message['status']?.toString() ?? '';

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 50.0 : 12.0,
        right: isMe ? 12.0 : 50.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isMe ? appDefaultColor : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
              bottomLeft: Radius.circular(isMe ? 16.0 : 4.0),
              bottomRight: Radius.circular(isMe ? 4.0 : 16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: TextStyle(
                  fontSize: 16.0,
                  color: isMe ? Colors.white : Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTimestamp(timestamp),
                    style: TextStyle(
                      fontSize: 11.0,
                      color: isMe ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                    ),
                  ),
                  if (isMe && status.isNotEmpty) ...[
                    const SizedBox(width: 4.0),
                    Icon(_getStatusIcon(status), size: 12.0, color: Colors.white.withOpacity(0.8)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'sent':
        return Icons.check;
      case 'delivered':
        return Icons.done_all;
      case 'seen':
      case 'read':
        return Icons.done_all;
      default:
        return Icons.access_time;
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    try {
      DateTime? dateTime;

      if (timestamp is String) {
        dateTime = DateTime.tryParse(timestamp);
      } else if (timestamp is DateTime) {
        dateTime = timestamp;
      }

      if (dateTime == null) return '';

      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        final month = months[dateTime.month - 1];
        final day = dateTime.day.toString().padLeft(2, '0');
        final hour = dateTime.hour.toString().padLeft(2, '0');
        final minute = dateTime.minute.toString().padLeft(2, '0');
        return '$month $day, $hour:$minute';
      } else {
        final hour = dateTime.hour.toString().padLeft(2, '0');
        final minute = dateTime.minute.toString().padLeft(2, '0');
        return '$hour:$minute';
      }
    } catch (_) {
      return '';
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: appDefaultColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chat', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('Tap to view contact info', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatMessageBloc, ChatMessageState>(
              listener: (context, state) {
                if (state is ChatMessageLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                }
              },
              builder: (context, state) {
                if (state is ChatMessageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatMessageLoaded) {
                  return _buildMessagesList(state.messages);
                } else if (state is ChatMessageError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}
