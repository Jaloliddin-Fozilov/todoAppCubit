import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/presentation/widgets/search_bar.dart';

import '../../logic/todo/todo_cubit.dart';

import '../widgets/todo_list_item.dart';
import '../widgets/manage_todo.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (ctx) => ManageTodo(),
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => openSearchBar(context),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos!.length,
            itemBuilder: (ctx, index) =>
                TodoListItem(todo: state.todos![index]),
          );
        },
      ),
    );
  }
}
