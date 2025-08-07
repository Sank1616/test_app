import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/chat_response_model.dart';

class ChatRepository {
  Future<List<ChatModel>> fetchUserChats(String userId) async {
    final url = Uri.parse('http://45.129.87.38:6065/chats/user-chats/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((json) => ChatModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }
}
