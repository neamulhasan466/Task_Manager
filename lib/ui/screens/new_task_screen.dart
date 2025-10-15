import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 🔹 Horizontal task count cards
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal, // ✅ Missing in your code
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const TaskCountByStatusCard(title: 'New', count: 2);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Task list
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    title: 'Completed Task ${index + 1}',
                    description: 'This task has been successfully finished.',
                    date: '16/10/2025',
                    status: 'New',
                    statusColor: Colors.green,
                    onDelete: () {
                      print('Delete clicked for item $index');
                    },
                    onEdit: () {
                      print('Edit clicked for item $index');
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
      (predicate) => false,
    );
  }
}
