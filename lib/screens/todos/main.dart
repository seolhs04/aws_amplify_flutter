import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/models/ModelProvider.dart';
import 'package:aws_amplify_flutter/widgets/todo/todos_list.dart';
import 'package:flutter/material.dart';

import 'add_todo_form.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool _isLoading = true;
  List<Todo> _todos = [];
  late StreamSubscription<QuerySnapshot<Todo>> _subscription;

  @override
  void initState() {
    _subscriptTodo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Future<void> _subscriptTodo() async {
    _subscription = Amplify.DataStore.observeQuery(Todo.classType)
        .listen((QuerySnapshot<Todo> snapshot) {
      setState(() {
        if (_isLoading) _isLoading = false;
        _todos = snapshot.items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TodosList(todos: _todos),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return const AddTodoForm();
              });
        },
        tooltip: 'Add Todo',
        label: Row(
          children: const [Icon(Icons.add), Text('Add todo')],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
