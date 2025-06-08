import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_unit_test_u9_3/providers/todo_providers.dart';
import 'package:todo_app_unit_test_u9_3/screens/add_todo_screen.dart';
import 'package:todo_app_unit_test_u9_3/widgets/todo_tile.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoTile(todo: todo);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTodoScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
