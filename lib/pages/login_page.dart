import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keycloak_flutter/keycloak_flutter.dart';


import '../main.dart';

class LoginPage extends StatefulWidget {
  final KeycloakService keycloakService;
  const LoginPage({Key? key, required this.keycloakService}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  void _login() {
    widget.keycloakService.login(
      KeycloakLoginOptions(
        scope: 'openid profile email',
        redirectUri: window.location.origin,
        prompt: 'login',
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/fblogo_svg.svg', semanticsLabel: 'Freightify Logo'),
            const Text(
              'Welcome to Raw Text Beautifier',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 35.0),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton.icon(
                onPressed: _login,
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: const Text('Login'),
              ),
            )
          ],
        ),
      ),

    );
  }
}
