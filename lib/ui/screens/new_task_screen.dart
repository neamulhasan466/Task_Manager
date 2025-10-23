import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
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
  bool _getAllNewTaskInProgress = false;

  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  /// Fetch both task status counts and new tasks
  Future<void> fetchAllData() async {
    await getAllTaskStatusCount();
    await getAllNewTask();
  }

  /// Fetch task status count from API
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

  /// Fetch all new tasks from API
  Future<void> getAllNewTask() async {
    setState(() {
      _getAllNewTaskInProgress = true;
    });

    final ApiResponse response =
    await ApiCaller.getRequest(url: Urls.newTaskListUrl);

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      setState(() {
        _newTaskList = list;
        _getAllNewTaskInProgress = false;
      });
    } else {
      setState(() {
        _getAllNewTaskInProgress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Failed to load new tasks'),
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

            // 🔹 New task list
            Expanded(
              child: _getAllNewTaskInProgress
                  ? const Center(child: CircularProgressIndicator())
                  : _newTaskList.isEmpty
                  ? const Center(
                child: Text(
                  'No new tasks found',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  final task = _newTaskList[index];
                  return TaskCard(
                        title: task.title,
                        description: task.description,
                        date: task.createdDate != null
                            ? task.createdDate!.substring(0, 10) // YYYY-MM-DD
                            : '',
                        status: task.status,
                        statusColor: _getStatusColor(task.status),
                        onDelete: () {
                          print('Delete clicked for ${task.title}');
                        },
                        onEdit: () {
                          print('Edit clicked for ${task.title}');
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

  /// Navigate to Add New Task screen
  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }

  /// Map task status to color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
