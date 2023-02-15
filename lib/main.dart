import 'dart:html';

import 'package:flutter/material.dart';
import 'package:keycloak_flutter/keycloak_flutter.dart';
import 'package:poc_sigin_task/pages/beautifier.dart';
import 'package:poc_sigin_task/pages/login_page.dart';

import 'main.dart';
import 'main.dart';

late KeycloakService keycloakService;

void main() {
  keycloakService = KeycloakService(
      KeycloakConfig(
      url: 'https://auth.freightbro.in/auth/', // Keycloak auth base url
      realm: 'freightbro_internal',
      clientId: 'flutter-local'));
  keycloakService.init(
    initOptions: KeycloakInitOptions(
      onLoad: 'check-sso',
      silentCheckSsoRedirectUri:
      '${window.location.origin}/silent-check-sso.html',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keycloak Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Keycloak demo', keycloakService: keycloakService,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final KeycloakService keycloakService;
  MyHomePage({Key? key, this.title, required this.keycloakService}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  KeycloakProfile? _keycloakProfile;
  bool showBeautifierPage=false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.keycloakService.keycloakEventsStream.listen((event) async {
        if (event.type == KeycloakEventType.onAuthSuccess) {
          setState(() {
            showBeautifierPage = true;
          });
        } else {
          _keycloakProfile = null;
        }
        setState(() {});
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController _inputController = TextEditingController();

    return MaterialApp(
      title: 'Parser Tool',
      theme:ThemeData(
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme(
          primary: Colors.black,
          secondary: Color(0xff1479F6),
          surface: Colors.white,
          background: Colors.white,
          error: Color(0xffb00020),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: showBeautifierPage ?BeautifierPage(keycloakService: keycloakService,) :LoginPage(keycloakService: keycloakService)
    );
  }
}
