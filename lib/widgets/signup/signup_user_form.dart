import 'package:flutter/material.dart';

class SignUpUserForm extends StatefulWidget {
  final bool isSendCode;
  final Future<void> Function(String, String) signUpUser;

  const SignUpUserForm({
    super.key,
    required this.isSendCode,
    required this.signUpUser,
  });

  @override
  State<SignUpUserForm> createState() => _SignUpUserFormState();
}

class _SignUpUserFormState extends State<SignUpUserForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'email',
              hintText: 'email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'password',
              hintText: 'password',
            ),
            validator: (value) {
              if (value!.length < 6) {
                return 'At least 6 Character';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'confirm password',
                hintText: 'confirm password',
              ),
              validator: (value) {
                if (value != passwordController.text) {
                  return 'Please check password';
                }
                return null;
              }),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: widget.isSendCode ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            child: TextButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                widget.signUpUser(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}
