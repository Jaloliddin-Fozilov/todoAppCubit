import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/todo/todo_bloc.dart';
import 'todo_list_item.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          query = '';
        },
        child: const Text('CLEAR'),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.watch<TodoBloc>().searchTodos(query);
    return todos.isEmpty
        ? const Center(
            child: Text('Can\'t find todos'),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoListItem(
              todo: todos[index],
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.watch<TodoBloc>().searchTodos(query);
      return todos.isEmpty
          ? const Center(
              child: Text('Can\'t find todos'),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => TodoListItem(
                todo: todos[index],
              ),
            );
    }
    return Container();
  }
}
