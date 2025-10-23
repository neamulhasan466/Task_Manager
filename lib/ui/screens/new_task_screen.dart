import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    getAllTaskStatusCount();
  }

  /// ✅ Fetch task status count from API
  Future<void> getAllTaskStatusCount() async {
    setState(() {
      _getTaskStatusCountInProgress = true;
    });

    final ApiResponse response =
    await ApiCaller.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }

      setState(() {
        _taskStatusCountList = list;
        _getTaskStatusCountInProgress = false;
      });
    } else {
      setState(() {
        _getTaskStatusCountInProgress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Failed to load task count'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 🔹 Task status count cards
            _getTaskStatusCountInProgress
                ? const Center(child: CircularProgressIndicator())
                : _taskStatusCountList.isEmpty
                ? const Center(
              child: Text(
                'No task status data found',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _taskStatusCountList.length,
                itemBuilder: (context, index) {
                  final item = _taskStatusCountList[index];
                  return TaskCountByStatusCard(
                    title: item.status,
                    count: item.count,
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(width: 8),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Example static task list (You can later replace this with API data)
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    title: 'Task ${index + 1}',
                    description: 'This task is currently new.',
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
                separatorBuilder: (context, index) =>
                const SizedBox(height: 8),
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

  /// ✅ Add new task navigation
  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }
}
