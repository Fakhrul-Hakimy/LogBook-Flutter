import 'dart:convert';
import 'package:http/http.dart' as http;


String? _accessToken;

class AuthService{

  static const BASE_URL = "https://api.fakhrulhakimy.tech/";

  AuthService();



  Future<bool> checkLogin(user) async {
    final response = await http.post(
      Uri.parse("${BASE_URL}token"),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': user.username,
        'password': user.password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      return true;
    } else {
      return false;
    }
  }

  // Verify token: call verify-token endpoint with Authorization header
  Future<bool> verifyToken() async {
    if (_accessToken == null) return false;

    final response = await http.get(
      Uri.parse("${BASE_URL}verify-token"),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      final data = jsonDecode(response.body);
      // Optionally read data['message'] or data['username']
      return true;
    } else {
      return false;
    }
  }

  // Getter for token, if needed outside this class
  String? get accessToken => _accessToken;
}

  



