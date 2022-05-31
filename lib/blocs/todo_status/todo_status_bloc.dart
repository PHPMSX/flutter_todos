import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todos/blocs/todo/todo_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/model.dart';

part 'todo_status_event.dart';
part 'todo_status_state.dart';

class TodoStatusBloc extends Bloc<TodoStatusEvent, TodoStatusState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _todoSubscription;

  TodoStatusBloc({required TodoBloc todoBloc})
      : _todoBloc = todoBloc,
        super(TodoStatusInitial()) {
    on<TodoStatusUpdateEvent>(_onUpdateTodoStatus);

    _todoSubscription = _todoBloc.stream.listen((state) {
      if (state is TodoLoaded) {
        add(TodoStatusUpdateEvent(todos: state.todos));
      }
    });
  }

  FutureOr<void> _onUpdateTodoStatus(
      TodoStatusUpdateEvent event, Emitter<TodoStatusState> emit) {
    final List<Todo> pendingTodos =
        event.todos.where((todo) => !todo.isCompleted).toList();
    final List<Todo> completedTodos =
        event.todos.where((todo) => todo.isCompleted).toList();

    emit(TodoStatusLoaded(
        pendingTodos: pendingTodos, completedTodos: completedTodos));
  }
}
