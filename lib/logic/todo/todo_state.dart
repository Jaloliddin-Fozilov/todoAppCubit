part of 'todo_cubit.dart';

@immutable
class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

class TodoInitial extends TodoState {
  final List<Todo> todos;

  const TodoInitial(this.todos);
}

class TodoAdded extends TodoState {}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  const TodosLoaded(this.todos) : super(todos: todos);
}

class TodoEdited extends TodoState {}

class TodoToggled extends TodoState {}

class TodoDeleted extends TodoState {}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
}
