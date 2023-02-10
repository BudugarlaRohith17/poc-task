import 'package:flutter/material.dart';
import 'package:poc_sigin_task/pages/sign_in.dart';

void main(){
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SignIn(),
    );

  }
}




