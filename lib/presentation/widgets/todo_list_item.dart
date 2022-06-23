import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/cubits/todo/todo_cubit.dart';
import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (ctx) => ManageTodo(
        todo: todo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () => context.read<TodoCubit>().toggleTodo(todo.id),
        icon: Icon(
          todo.isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
        ),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration:
              todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => context.read<TodoCubit>().deleteTodo(todo.id),
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
