import 'package:aws_amplify_flutter/models/Todo.dart';
import 'package:aws_amplify_flutter/widgets/todo/todo_item.dart';
import 'package:flutter/material.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    required this.todos,
    Key? key,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final currentTodo = todos[index];
              return TodoItem(todo: currentTodo);
            },
          )
        : const Center(
            child: Text('Tap button below to add a todo!'),
          );
  }
}
