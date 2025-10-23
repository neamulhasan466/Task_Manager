import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
             // return TaskCard(
                // title: 'Completed Task ${index + 1}',
                // description: 'This task has been successfully finished.',
                // date: '16/10/2025',
                // status: 'In Progress',
                // statusColor: Colors.orange,
                // onDelete: () {
                //   print('Delete clicked for item $index');
                // },
                // onEdit: () {
                //   print('Edit clicked for item $index');
                // },
             // );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ),
    );
  }
}
