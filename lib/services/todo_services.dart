import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_unit_test_u9_3/models/todo_model.dart';

class TodoServices {
  final Box<Todo> _box = Hive.box<Todo>('todos');
  List<Todo> getTodos() => _box.values.toList();

  Future<void> addTodo(Todo todo) async {
    await _box.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await _box.delete(id);
  }

  Future<void> updateTodo(Todo todo) async {
    await _box.put(todo.id, todo);
  }
}
