part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  const TodoEvent();
}

class LoadTodosEvent extends TodoEvent {
  final List<Todo> todos;

  const LoadTodosEvent({this.todos = const <Todo>[]});
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  const DeleteTodoEvent({required this.todo});
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  const UpdateTodoEvent({required this.todo});
}
