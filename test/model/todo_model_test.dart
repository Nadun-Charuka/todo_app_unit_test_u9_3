import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_unit_test_u9_3/models/todo_model.dart';

void main() {
  test(
    "Todo model should create an instance correctly",
    () {
      final todo = Todo(id: "1", title: "Test todo");
      expect(todo.id, "1");
      expect(todo.title, "Test todo");
      expect(todo.isCompleted, false);

      final updatedTodo = todo.copyWith(title: "Updated todo");
      expect(updatedTodo.id, "1");
      expect(updatedTodo.title, "Updated todo");
      expect(updatedTodo.isCompleted, false);
    },
  );
}
