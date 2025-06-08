import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_unit_test_u9_3/providers/todo_providers.dart';

class AddTodoScreen extends ConsumerWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  ref
                      .read(todoListProvider.notifier)
                      .addTodo(controller.text.trim());
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
