import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/widgets/signup/code_verify_form.dart';
import 'package:aws_amplify_flutter/widgets/signup/signup_user_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSendCode = false;
  String userEmail = '';

  Future<void> signUpUser(email, password) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
      );

      setState(() {
        isSendCode = true;
        userEmail = email;
      });
      displayMessage('success', 'Check your email');
    } on AuthException catch (e) {
      displayMessage('error', e.message);
    }
  }

  Future<void> confirmCode(String code) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: userEmail,
        confirmationCode: code,
      );
      displayMessage('success', 'Success confirm. Please login');
      if (mounted) Navigator.pop(context);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  void displayMessage(String type, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignUp')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpUserForm(
                isSendCode: isSendCode,
                signUpUser: signUpUser,
              ),
              AnimatedOpacity(
                  opacity: isSendCode ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: CodeVerifyForm(confirmCode: confirmCode))
            ],
          ),
        ),
      ),
    );
  }
}
