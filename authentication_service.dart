import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationService {
  Future<void> authenticateUser(String user, String password) async {
    final response = await http.get(Uri.parse('http://192.168.1.69:8080/user'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var userData in data) {
        if (userData['user'] == user && userData['password'] == password) {
          return;
        }
      }

      throw Exception("Credenciales incorrectas");
    } else {
      throw Exception("Error al conectarse a la API");
    }
  }
}
