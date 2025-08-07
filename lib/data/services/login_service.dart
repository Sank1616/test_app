
import 'dart:convert';

import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>> login(String email, String password, String role) async {
    final url = Uri.parse('$baseUrl/user/login');
    final body = {
      "email": email,
      "password": password,
      "role": role,
    };

    logger.i("📤 Sending login request: $body");

    final response = await http.post(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });

    logger.i("📥 Login response: ${response.body}");

    return jsonDecode(response.body);
  }
}
