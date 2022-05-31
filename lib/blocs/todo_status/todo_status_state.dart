part of 'todo_status_bloc.dart';

@immutable
abstract class TodoStatusState {
  const TodoStatusState();
}

class TodoStatusInitial extends TodoStatusState {}

class TodoStatusLoaded extends TodoStatusState {
  final List<Todo> pendingTodos;
  final List<Todo> completedTodos;

  const TodoStatusLoaded(
      {required this.pendingTodos, required this.completedTodos});
}
