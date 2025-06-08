import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:todo_app_unit_test_u9_3/providers/todo_providers.dart';

import 'package:todo_app_unit_test_u9_3/models/todo_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  late ProviderContainer container;

  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    await Hive.openBox<Todo>('todos');

    container = ProviderContainer();
  });

  tearDown(() async {
    await tearDownTestHive();
    container.dispose();
  });

  test('should start with empty todo list', () {
    final todos = container.read(todoListProvider);
    expect(todos, isEmpty);
  });

  test('should add a todo', () async {
    final notifier = container.read(todoListProvider.notifier);

    await notifier.addTodo('New Todo');

    final todos = container.read(todoListProvider);
    expect(todos.length, 1);
    expect(todos.first.title, 'New Todo');
    expect(todos.first.isCompleted, false);
  });

  test('should update a todo title', () async {
    final notifier = container.read(todoListProvider.notifier);
    await notifier.addTodo('Old Title');
    var todo = container.read(todoListProvider).first;

    await notifier.updateTodo(todo.id, 'Updated Title');

    final updatedTodo = container.read(todoListProvider).first;
    expect(updatedTodo.title, 'Updated Title');
  });

  test('should delete a todo', () async {
    final notifier = container.read(todoListProvider.notifier);
    await notifier.addTodo('To Delete');
    var todo = container.read(todoListProvider).first;

    await notifier.deleteTodo(todo.id);

    expect(container.read(todoListProvider), isEmpty);
  });

  test('should toggle todo completion', () async {
    final notifier = container.read(todoListProvider.notifier);
    await notifier.addTodo('To Toggle');
    var todo = container.read(todoListProvider).first;

    await notifier.toggleTodo(todo);

    final toggledTodo = container.read(todoListProvider).first;
    expect(toggledTodo.isCompleted, true);
  });
}
