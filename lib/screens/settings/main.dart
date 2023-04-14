import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/screens/login/main.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<void> signOutCurrentUser(context) async {
    try {
      await Amplify.Auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout success')),
      );
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: TextButton(
          onPressed: () {
            signOutCurrentUser(context);
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          child: const Text(
            'LOGOUT',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
