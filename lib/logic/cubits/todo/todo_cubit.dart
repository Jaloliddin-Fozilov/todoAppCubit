import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/todo.dart';
import '../user/user_cubit.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;

  TodoCubit({required this.userCubit})
      : super(TodoInitial(
          [
            Todo(
              id: UniqueKey().toString(),
              title: 'Go home',
              userId: '1',
              isDone: false,
            ),
            Todo(
              id: UniqueKey().toString(),
              title: 'Go shoping',
              userId: '1',
              isDone: true,
            ),
            Todo(
              id: UniqueKey().toString(),
              title: 'Go working',
              userId: '2',
              isDone: false,
            ),
          ],
        ));

  void getTodos() {
    final user = userCubit.currentUser;
    final todos = state.todos!.where((todo) => todo.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void addTodo(String title) {
    final user = userCubit.currentUser;
    try {
      final todo = Todo(
        id: UniqueKey().toString(),
        title: title,
        userId: user.id,
      );
      final todos = [...state.todos!, todo];
      emit(TodoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured'));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == id) {
          return Todo(id: id, title: title, userId: t.userId, isDone: t.isDone);
        }
        return t;
      }).toList();
      emit(TodoEdited());
      emit(TodosLoaded(todos));
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
            userId: t.userId,
          );
        }
        return t;
      },
    ).toList();
    emit(TodoToggled());
    emit(TodosLoaded(todos));
  }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(TodoDeleted());
    emit(TodosLoaded(todos));
  }

  List<Todo> searchTodos(String title) {
    return state.todos!
        .where(
          (todo) => todo.title.toLowerCase().contains(title.toLowerCase()),
        )
        .toList();
  }
}
