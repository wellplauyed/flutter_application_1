import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> registerUser(User user) async {
    final url = Uri.parse(
      'http://10.0.2.2/my_flutter_backend/register.php',
    ); // Replace this
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return {'status': true, 'message': 'Registration successful'};
    } else {
      return {'status': false, 'message': 'Registration failed'};
    }
  }
}
