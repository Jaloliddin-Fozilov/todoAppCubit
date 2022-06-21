import 'package:flutter/material.dart';

import '../../data/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        todo.isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
      ),
      title: Text(todo.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
