import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/routes/update_task_screen.dart';
import 'package:task_management_app/services/task_service.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.task),
              title: Text(task.description,
                  style: Theme.of(context).textTheme.bodyLarge),
              subtitle: Text('description',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.access_time_filled_sharp),
              title: Text(task.deadline.toString().substring(0, 16),
                  style: Theme.of(context).textTheme.bodyLarge),
              subtitle: Text('Deadline',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(Icons.priority_high),
              title: Text(
                task.priority == 1
                    ? 'Low'
                    : task.priority == 2
                        ? 'Medium'
                        : 'High',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text('Priority',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // delete the task
                      Provider.of<TaskService>(context, listen: false)
                          .deleteTask(task.id);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async{
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateTaskScreen(task: task)));
                                  Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
