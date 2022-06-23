import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/data/models/todo.dart';
import 'package:todoapp/logic/blocs/user/user_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserBloc userBloc;
  TodoBloc(this.userBloc)
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
        )) {
    on<LoadTodosEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _getTodos(LoadTodosEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;
    final todos = state.todos!.where((todo) => todo.userId == user.id).toList();
    emit(TodosLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;
    try {
      final todo = Todo(
        id: UniqueKey().toString(),
        title: event.title,
        userId: user.id,
      );
      final todos = [...state.todos!, todo];
      emit(TodoAdded());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured'));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == event.id) {
          return Todo(
              id: event.id,
              title: event.title,
              userId: t.userId,
              isDone: t.isDone);
        }
        return t;
      }).toList();
      emit(TodoEdited());
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured'));
    }
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos!.map(
      (t) {
        if (t.id == event.id) {
          return Todo(
            id: event.id,
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

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == event.id);
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
