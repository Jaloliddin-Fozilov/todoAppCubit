import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'completed_todos_event.dart';
part 'completed_todos_state.dart';

class CompletedTodosBloc
    extends Bloc<CompletedTodosEvent, CompletedTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoBloc todoBloc;
  CompletedTodosBloc(this.todoBloc) : super(CompletedTodosInitial()) {
    todoCubitSubscription = todoBloc.stream.listen((event) {
      add(LoadCompletedTodosEvenet());
    });
    on<LoadCompletedTodosEvenet>(_getCompletedTodos);
  }

  void _getCompletedTodos(
      LoadCompletedTodosEvenet event, Emitter<CompletedTodosState> emit) {
    final todos = todoBloc.state.todos!.where((todo) => todo.isDone).toList();
    emit(CompletedTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
