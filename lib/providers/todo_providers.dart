import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_unit_test_u9_3/models/todo_model.dart';
import 'package:todo_app_unit_test_u9_3/services/todo_services.dart';
import 'package:uuid/uuid.dart';

final todoServiceProvider = Provider((ref) => TodoServices());

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  final service = ref.watch(todoServiceProvider);
  return TodoListNotifier(service);
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  final TodoServices _service;
  TodoListNotifier(this._service) : super([]) {
    _loadTodos();
  }

  void _loadTodos() {
    state = _service.getTodos();
  }

  Future<void> addTodo(String title) async {
    final todo = Todo(id: Uuid().v4(), title: title);
    await _service.addTodo(todo);
    _loadTodos();
  }

  Future<void> updateTodo(String id, String newTitle) async {
    final todo = state.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(title: newTitle);
    await _service.updateTodo(updated);
    _loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _service.deleteTodo(id);
    _loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    final updated = todo.copyWith(isCompleted: !todo.isCompleted!);
    await _service.updateTodo(updated);
    _loadTodos();
  }
}
