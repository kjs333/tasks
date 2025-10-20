// 2번
class ToDoEntity {
  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
  final DateTime createAt;

  ToDoEntity({
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
    required this.createAt,
  });
}
