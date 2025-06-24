import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2/eportal2025-us/backend/api/AccountController.php',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return {'status': true, 'message': 'Registration successful'};
      } else if (response.statusCode == 400) {
        return {
          'status': false,
          'message': 'Bad request. Please check your input.',
        };
      } else {
        return {
          'status': false,
          'message': 'Registration failed. Please try again later.',
        };
      }
    } catch (e) {
      return {'status': false, 'message': 'An error occurred: $e'};
    }
  }
}
