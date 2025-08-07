import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatsService {
  Future<List> getChatMessages(String chatId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/messages/get-messagesformobile/$chatId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      logger.d('Response status: ${response.statusCode}');
      logger.d('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('messages')) {
          return decodedResponse['messages'] as List;
        } else if (decodedResponse is List) {
          return decodedResponse;
        } else {
          logger.e('Unexpected response structure: $decodedResponse');
          throw Exception('Unexpected response structure');
        }
      } else {
        logger.e('Failed to load messages. Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error in getChatMessages: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> sendMessage(
      String chatId,
      String senderId,
      String content,
      String messageType,
      String fileUrl,
      ) async {
    try {
      final requestBody = {
        "chatId": chatId,
        "senderId": senderId,
        "content": content,
        "messageType": messageType,
        "fileUrl": fileUrl,
      };

      logger.d('Sending message with payload: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/messages/sendMessage'), // Use baseUrl instead of hardcoded URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      logger.d('Send message response status: ${response.statusCode}');
      logger.d('Send message response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Return the response data if successful
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        }
        return null;
      } else {
        logger.e('Failed to send message. Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to send message: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      logger.e('Error in sendMessage: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getChatDetails(String chatId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chats/$chatId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      logger.d('Get chat details response status: ${response.statusCode}');
      logger.d('Get chat details response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        logger.e('Failed to get chat details. Status: ${response.statusCode}');
        throw Exception('Failed to get chat details: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error in getChatDetails: $e');
      rethrow;
    }
  }

  Future<void> markMessagesAsSeen(String chatId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages/mark-as-seen'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "chatId": chatId,
          "userId": userId,
        }),
      );

      logger.d('Mark as seen response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        logger.e('Failed to mark messages as seen. Status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error in markMessagesAsSeen: $e');
    }
  }
}



class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;

  factory SocketService() => _instance;

  SocketService._internal();

  void connect(String userId) {
    socket = IO.io('https://your-server.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': {'userId': userId},
    });

    socket.onConnect((_) => print('Socket connected'));
    socket.onDisconnect((_) => print('Socket disconnected'));
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('send_message', message);
  }

  void onReceiveMessage(Function(dynamic) callback) {
    socket.on('receive_message', callback);
  }

  void disconnect() {
    socket.disconnect();
  }
}

