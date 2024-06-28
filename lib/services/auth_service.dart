import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://pizzas.shrp.dev';

  Future<bool> createAccount(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'role': "bad526d9-bc5a-45f1-9f0b-eafadcd4fc15",
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create account');
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Store the token in a secure storage for future use
      // final token = jsonDecode(response.body)['token'];
      // await _secureStorage.write(key: 'token', value: token);
      return true;
    } else {
      throw Exception('Failed to login');
    }
  }
}
