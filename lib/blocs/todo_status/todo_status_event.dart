part of 'todo_status_bloc.dart';

@immutable
abstract class TodoStatusEvent {
  const TodoStatusEvent();
}

class TodoStatusUpdateEvent extends TodoStatusEvent {
  final List<Todo> todos;
  const TodoStatusUpdateEvent({required this.todos});
}
