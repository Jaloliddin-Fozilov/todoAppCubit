import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/data/models/todo.dart';
import 'package:todoapp/logic/todo/todo_cubit.dart';

part 'completed_todos_state.dart';

class CompletedTodosCubit extends Cubit<CompletedTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoCubit todoCubit;
  CompletedTodosCubit(this.todoCubit) : super(CompletedTodosInitial()) {
    todoCubitSubscription = todoCubit.stream.listen((TodoState state) {
      getCopletedTodos();
    });
  }

  void getCopletedTodos() {
    final todos = todoCubit.state.todos!.where((todo) => todo.isDone).toList();

    emit(CompletedTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
