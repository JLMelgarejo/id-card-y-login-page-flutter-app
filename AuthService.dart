import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String databaseUrl = 'https://userypassw-31fe6-default-rtdb.firebaseio.com/';

  Future<String> authenticate(String username, userPassword) async {
    final response = await http.get(Uri.parse('$databaseUrl/users/$username.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['password'] == userPassword) {
        return 'success';
      } else {
        return 'password';
      }
    } else if (response.statusCode == 404) {
      return 'user';
    } else {
      return 'error';
    }
  }
}