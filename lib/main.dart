import 'package:aws_amplify_flutter/screens/main_route.dart';
import 'package:aws_amplify_flutter/utils/amplify_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  Future<void> _initializeApp() async {
    await AmplifyService().config();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const MainRoute(),
    );
  }
}
