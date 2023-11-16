import 'package:flutter/material.dart';
import 'id_card.dart';
import 'authentication_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = "";
  final AuthenticationService _authenticationService = AuthenticationService();  // Instanciar el servicio

  Future<void> login() async {
    final user = userController.text;
    final password = passwordController.text;

    try {
      await _authenticationService.authenticateUser(user, password);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IdCard()),
      );
    } catch (e) {
      setState(() {
        message = "Credenciales incorrectas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de Sesión"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),
            ElevatedButton(
              onPressed: login,
              child: Text("Iniciar Sesión"),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
