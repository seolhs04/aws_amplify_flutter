import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/models/Todo.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final double iconSize = 24.0;
  final Todo todo;

  void _deleteTodo(BuildContext context) async {
    try {
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      safePrint('An error occurred while deleting Todo: $e');
    }
  }

  Future<void> _toggleIsComplete() async {
    final updateTodo = todo.copyWith(isComplete: !(todo.isComplete as bool));
    try {
      await Amplify.DataStore.save(updateTodo);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _toggleIsComplete();
        },
        onLongPress: () {
          _deleteTodo(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(todo.description ?? 'No description'),
                ],
              ),
            ),
            Icon(
                todo.isComplete as bool
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                size: iconSize),
          ]),
        ),
      ),
    );
  }
}
