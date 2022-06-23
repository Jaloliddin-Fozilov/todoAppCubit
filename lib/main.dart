import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/logic/blocs/active_todos/active_todos_bloc.dart';
import 'package:todoapp/logic/blocs/todo/todo_bloc.dart';
import 'package:todoapp/logic/blocs/user/user_bloc.dart';
import 'logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'presentation/screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserBloc(),
        ),
        BlocProvider(
          create: (ctx) => TodoBloc(ctx.read<UserBloc>()),
        ),
        BlocProvider(
          create: (ctx) => ActiveTodosBloc(ctx.read<TodoBloc>()),
        ),
        BlocProvider(
          create: (ctx) => CompletedTodosBloc(ctx.read<TodoBloc>()),
        ),
      ],
      child: MaterialApp(
        title: 'TODOS APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosScreen(),
      ),
    );
  }
}
