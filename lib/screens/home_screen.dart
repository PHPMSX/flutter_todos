import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/todo/todo_bloc.dart';
import 'package:flutter_todos/blocs/todo_status/todo_status_bloc.dart';
import 'package:flutter_todos/models/model.dart';
import 'package:flutter_todos/screens/add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getTodos();
    super.initState();
  }

  Future<void> getTodos() async {
    await Future.delayed(const Duration(seconds: 3));
    BlocProvider.of<TodoBloc>(context).add(LoadTodosEvent(todos: Todo.todos));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BloC Pattern: Todos'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTodoScreen()));
                },
                icon: const Icon(Icons.add)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.pending,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add_task,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _todoListWidget('Pending List', false),
            _todoListWidget('Completed List', true)
          ],
        ),
      ),
    );
  }

  Widget _todoListWidget(String title, bool isCompleted) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<TodoStatusBloc, TodoStatusState>(
          builder: (context, state) {
            if (state is TodoStatusLoaded) {
              final List<Todo> todos =
                  isCompleted ? state.completedTodos : state.pendingTodos;
              if (todos.isEmpty) {
                return const Expanded(
                    child: Center(
                  child: Text(
                    'Todo List is empty !',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ));
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return _todoCard(todos[index], context);
                    });
              }
            }
            return const Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          },
        )
      ],
    );
  }

  Card _todoCard(Todo todo, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                if (!todo.isCompleted)
                  IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(UpdateTodoEvent(todo: todo));
                    },
                    icon: const Icon(Icons.add_task),
                  ),
                IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteTodoEvent(todo: todo));
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
