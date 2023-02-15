import 'dart:html';

import 'package:flutter/material.dart';
import 'package:keycloak_flutter/keycloak_flutter.dart';

import '../main.dart';

class BeautifierPage extends StatefulWidget {
  final KeycloakService keycloakService;
  const BeautifierPage({Key? key, required this.keycloakService}) : super(key: key);

  @override
  State<BeautifierPage> createState() => _BeautifierPageState();
}


class _BeautifierPageState extends State<BeautifierPage>{

  final TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              widget.keycloakService.logout();
            }, icon: const Icon(Icons.logout))
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 30.0, left: 20.0, right: 50.0),
                child: TextField(
                  cursorColor: Colors.black,
                  scrollPadding: EdgeInsets.zero,
                  controller: _inputController,
                  decoration: const InputDecoration(
                      hintText: 'Enter Input Payload',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black87)),
              onPressed: () {},
              child: const Text(
                'Convert',
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30.0, right: 20.0, left: 50.0),
                  child: const TextField(
                    cursorColor: Colors.black,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Result'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                  ),
                )),
            // FloatingActionButton.extended(onPressed: (){_handleSignOut();},label: const Text('Sign Out'),),
          ],
        )
    );
  }
}
