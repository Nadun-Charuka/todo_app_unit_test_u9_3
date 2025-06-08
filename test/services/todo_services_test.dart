import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:todo_app_unit_test_u9_3/models/todo_model.dart';
import 'package:todo_app_unit_test_u9_3/services/todo_services.dart';

void main() {
  late TodoServices service;
  setUp(
    () async {
      await setUpTestHive();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TodoAdapter());
      }
      await Hive.openBox<Todo>('todos');
      service = TodoServices();
    },
  );

  tearDown(
    () async {
      await tearDownTestHive();
    },
  );

  test(
    "should add and get todo",
    () async {
      final todo = Todo(id: "1", title: "Test Todo");
      await service.addTodo(todo);

      final todos = service.getTodos();
      expect(todos.length, 1);
      expect(todos.first.title, "Test Todo");
    },
  );

  test(
    "should delete a todo",
    () async {
      final todo = Todo(id: "2", title: "To Delete");
      await service.addTodo(todo);

      await service.deleteTodo('2');
      expect(service.getTodos().isEmpty, true);
    },
  );

  test(
    "should update a todo",
    () async {
      final todo = Todo(id: "3", title: "Before");
      await service.addTodo(todo);

      final updated = todo.copyWith(title: "After");
      await service.updateTodo(updated);

      expect(service.getTodos().first.title, "After");
    },
  );
}
