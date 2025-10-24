import 'package:flutter/material.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String status;
  final Color statusColor;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    this.statusColor = Colors.green,
    this.onDelete,
    this.onEdit,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white,
      title: Text(widget.title),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.description),
            const SizedBox(height: 6),
            Text(
              'Date: ${widget.date}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // 👇 Make Chip clickable
                GestureDetector(
                  onTap: _showChangeStatusDialog,
                  child: Chip(
                    label: Text(widget.status),
                    backgroundColor: widget.statusColor,
                    labelStyle: const TextStyle(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.delete, color: Colors.grey),
                ),
                IconButton(
                  onPressed: widget.onEdit,
                  icon: const Icon(Icons.edit, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Change Task Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New'),
                onTap: () {
                  Navigator.pop(ctx);
                  _changeStatus('New');
                },
              ),
              ListTile(
                title: const Text('In Progress'),
                onTap: () {
                  Navigator.pop(ctx);
                  _changeStatus('In Progress');
                },
              ),
              ListTile(
                title: const Text('Completed'),
                onTap: () {
                  Navigator.pop(ctx);
                  _changeStatus('Completed');
                },
              ),
              ListTile(
                title: const Text('Cancelled'),
                onTap: () {
                  Navigator.pop(ctx);
                  _changeStatus('Cancelled');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _changeStatus(String newStatus)  {
    setState(() async {
      _changeStatusInProgress = true;
      final ApiResponse response = await ApiCaller.getRequest(url: Urls.loginUrl);
      
    });

    // Simulate a delay or API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _changeStatusInProgress = false;
      });

      print('Status changed to: $newStatus');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task status changed to $newStatus')),
      );
    });
  }
}
