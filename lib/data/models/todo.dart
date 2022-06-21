class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });
}
