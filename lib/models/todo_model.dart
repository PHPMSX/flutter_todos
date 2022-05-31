import 'package:equatable/equatable.dart';

enum TodoStatus { completed, pending }

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  final bool isCompleted;

  const Todo(
      {required this.id,
      required this.task,
      required this.description,
      this.isCompleted = false});

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
      ];

  static List<Todo> todos = const [
    Todo(
      id: '1',
      task: 'Sample ToDo 1',
      description: 'This is a test To Do',
    ),
    Todo(
      id: '2',
      task: 'Sample ToDo 2',
      description: 'This is a test To Do',
    ),
  ];
}
