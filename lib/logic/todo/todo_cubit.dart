import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(TodoInitial(
          [
            Todo(
              id: UniqueKey().toString(),
              title: 'Go home',
              isDone: false,
            ),
            Todo(
              id: UniqueKey().toString(),
              title: 'Go shoping',
              isDone: true,
            ),
            Todo(
              id: UniqueKey().toString(),
              title: 'Go working',
              isDone: false,
            ),
          ],
        ));

  void addTodo(String title) {
    try {
      final todo = Todo(
        id: UniqueKey().toString(),
        title: title,
      );
      final todos = state.todos;
      todos.add(todo);
      emit(TodoAdded(todos));
      emit(TodoState(todos));
    } catch (e) {
      emit(TodoError('Error occured', state.todos));
    }
  }
}
