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
      final todos = [...state.todos!, todo];
      emit(TodoAdded());
      emit(TodoState(todos: todos));
    } catch (e) {
      emit(const TodoError('Error occured'));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == id) {
          return Todo(id: id, title: title, isDone: t.isDone);
        }
        return t;
      }).toList();
      emit(TodoEdited());
      emit(TodoState(todos: todos));
    } catch (e) {
      emit(const TodoError('Error occured'));
    }
  }

  void toggleTodo(String id) {
    final todos = state.todos!.map(
      (t) {
        if (t.id == id) {
          return Todo(
            id: id,
            title: t.title,
            isDone: !t.isDone,
          );
        }
        return t;
      },
    ).toList();
    emit(TodoToggled());
    emit(TodoState(todos: todos));
  }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(TodoDeleted());
    emit(TodoState(todos: todos));
  }
}
