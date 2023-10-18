import 'package:flutter/material.dart';
import 'AuthService.dart';
import 'IdCardScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';
  final AuthService _authService = AuthService(); // Instancia de AuthService

  void _navigateToIdCard(BuildContext context) async {
    String username = _usernameController.text;
    String userPassword = _passwordController.text;

    String authResult = await _authService.authenticate(username, userPassword);

    if (authResult == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IdCard()),
      );
    } else {
      setState(() {
        if (authResult == 'password') {
          errorMessage = 'Contraseña incorrecta. ¿Desea recuperar su contraseña?';
        } else if (authResult == 'user') {
          errorMessage = 'Usuario no registrado.';
        } else {
          errorMessage = 'Credenciales incorrectas.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateToIdCard(context);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}