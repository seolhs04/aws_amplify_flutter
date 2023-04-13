import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/models/ModelProvider.dart';
import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({Key? key}) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  Future<void> _saveTodo() async {
    final name = _nameController.text;
    final description = _descriptionController.text;

    final newTodo = Todo(
      name: name,
      description: description.isNotEmpty ? description : null,
      isComplete: false,
    );
    try {
      await Amplify.DataStore.save(newTodo);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(filled: true, labelText: 'Name'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    filled: true, labelText: 'Description'),
              ),
              ElevatedButton(
                onPressed: _saveTodo,
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
