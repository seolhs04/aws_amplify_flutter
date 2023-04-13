import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/amplifyconfiguration.dart';
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
    _initializeApp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();

    _subscription = Amplify.DataStore.observeQuery(Todo.classType)
        .listen((QuerySnapshot<Todo> snapshot) {
      setState(() {
        if (_isLoading) _isLoading = false;
        _todos = snapshot.items;
      });
    });
  }

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins
      final dataStorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);
      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([dataStorePlugin, apiPlugin, authPlugin]);

      // note that Amplify cannot be configured more than once!
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      safePrint('An error occurred while configuring Amplify: $e');
    }
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
