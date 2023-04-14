import 'package:flutter/material.dart';

class CodeVerifyForm extends StatefulWidget {
  final Future<void> Function(String) confirmCode;

  const CodeVerifyForm({
    super.key,
    required this.confirmCode,
  });

  @override
  State<CodeVerifyForm> createState() => _CodeVerifyFormState();
}

class _CodeVerifyFormState extends State<CodeVerifyForm> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: codeController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'verification code',
              hintText: 'verification code',
            ),
            validator: (value) {
              if (value!.length != 6) {
                return 'Please check code';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              widget.confirmCode(codeController.text);
            },
            child: const Text('confirm'),
          ),
        ],
      ),
    );
  }
}
