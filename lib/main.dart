import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/logic/active_todos/active_todos_cubit.dart';
import 'logic/completed_todos/copleted_todos_cubit.dart';
import 'logic/user/user_cubit.dart';

import 'logic/todo/todo_cubit.dart';

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
          create: (ctx) => UserCubit(),
        ),
        BlocProvider(
          create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>()),
        ),
        BlocProvider(
          create: (ctx) => ActiveTodosCubit(ctx.read<TodoCubit>()),
        ),
        BlocProvider(
          create: (ctx) => CompletedTodosCubit(ctx.read<TodoCubit>()),
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
