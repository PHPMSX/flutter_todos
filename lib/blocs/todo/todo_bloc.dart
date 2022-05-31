import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/model.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onLoadTodos(LoadTodosEvent event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      final List<Todo> todos = List.from(state.todos)..add(event.todo);
      emit(TodoLoaded(todos: todos));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      final List<Todo> todoList = List.of(state.todos);
      todoList.remove(event.todo);
      emit(TodoLoaded(todos: todoList));
    }
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      final List<Todo> todoList = List.of(state.todos);
      todoList.remove(event.todo);
      todoList.add(event.todo.copyWith(isCompleted: true));

      emit(TodoLoaded(todos: todoList));
    }
  }
}
