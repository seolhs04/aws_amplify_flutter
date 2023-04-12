import 'package:flutter/material.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
          child: Column(
        children: List.generate(100, (index) => index + 1)
            .map((e) => Text(e.toString()))
            .toList(),
      )),
    );
  }
}
