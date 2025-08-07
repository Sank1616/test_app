import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String baseUrl = 'http://45.129.87.38:6065';

  Future<List<dynamic>> getUserChats(String userId) async {
    final url = Uri.parse('$baseUrl/chats/user-chats/$userId');

    final response = await http.get(url);
    print(url);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse as needed
    } else {
      throw Exception('Failed to load user chats');
    }
  }
}
