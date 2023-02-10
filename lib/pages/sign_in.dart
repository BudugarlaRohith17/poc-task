import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_network/image_network.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GoogleSignInAccount? _currentUser;
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  final TextEditingController _inputController = TextEditingController();

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentUser == null
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: Image.asset(
                'assets/logo.png',
                scale: 2.5,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _handleSignOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
      body: login(),
    );
  }

  Widget login() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Row(
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
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/freightify.png'),
            fit: BoxFit.cover,
            height: 150.0,
          ),
          const Center(
              child: Text(
            'Hi User! Please Sign In',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50.0),
          )),

          FloatingActionButton.extended(
            onPressed: () {
              _handleSignIn();
            },
            icon: Image.asset(
              'assets/google.png',
              height: 32,
              width: 32,
            ),
            label: const Text('Sign in with Google'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ],
      );
    }
  }
}
