// -----------------------------------------------------------------------------
// 1. Task Model
// -----------------------------------------------------------------------------
class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });

  // Convert a Task object into a Map for the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0, // SQLite stores boolean as 0 or 1
    };
  }

  // Convert a Map from the database into a Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}