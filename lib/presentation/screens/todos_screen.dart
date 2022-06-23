import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:todoapp/logic/blocs/completed_todos/completed_todos_bloc.dart';

import '../../data/constants/tab_titles_constants.dart';
import '../../logic/blocs/todo/todo_bloc.dart';
import '../widgets/manage_todo.dart';
import '../widgets/search_bar.dart';
import '../widgets/todo_list_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool _init = false;
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
  void didChangeDependencies() {
    if (!_init) {
      context.read<TodoBloc>().add(LoadTodosEvent());
      context.read<ActiveTodosBloc>().add(LoadActiveTodosEvenet());
      context.read<CompletedTodosBloc>().add(LoadCompletedTodosEvenet());
    }
    _init = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitlesConstants.tabs.length,
      child: Scaffold(
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
          bottom: TabBar(
              tabs: TabTitlesConstants.tabs
                  .map((tab) => Tab(
                        text: tab,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (ctx, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
            BlocBuilder<ActiveTodosBloc, ActiveTodosState>(
              builder: (context, state) {
                if (state is ActiveTodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (ctx, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
            BlocBuilder<CompletedTodosBloc, CompletedTodosState>(
              builder: (context, state) {
                if (state is CompletedTodosLoaded) {
                  return state.todos.isEmpty
                      ? const Center(
                          child: Text('No todos'),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (ctx, index) =>
                              TodoListItem(todo: state.todos[index]),
                        );
                }
                return const Center(
                  child: Text('No todos'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
