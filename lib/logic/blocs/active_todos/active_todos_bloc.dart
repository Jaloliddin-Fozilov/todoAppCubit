import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  late final StreamSubscription todoCubitSubscription;
  final TodoBloc todoBloc;
  ActiveTodosBloc(this.todoBloc) : super(ActiveTodosInitial()) {
    todoCubitSubscription = todoBloc.stream.listen((event) {
      add(LoadActiveTodosEvenet());
    });
    on<LoadActiveTodosEvenet>(_getActiveTodos);
  }

  void _getActiveTodos(
      LoadActiveTodosEvenet event, Emitter<ActiveTodosState> emit) {
    final todos = todoBloc.state.todos!.where((todo) => !todo.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
