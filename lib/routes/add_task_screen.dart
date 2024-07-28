import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/services/task_service.dart';

class AddTaskScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _priorityController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a description' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _deadlineController,
                  decoration: InputDecoration(
                      labelText: 'Deadline',
                      suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            ).then((value) => _deadlineController.text =
                                value != null ? value.toString() : '');
                          },
                          icon: Icon(Icons.calendar_today))),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a deadline' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _priorityController,
                  decoration:
                      const InputDecoration(labelText: 'Priority (1 - 3)'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a priority' : null,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          id: '',
                          title: _titleController.text,
                          description: _descriptionController.text,
                          deadline: DateTime.parse(_deadlineController.text),
                          priority: int.parse(_priorityController.text) == 1
                              ? 'Low'
                              : int.parse(_priorityController.text) == 2
                                  ? 'Medium'
                                  : 'High',
                        );
                        Provider.of<TaskService>(context, listen: false)
                            .addTask(task);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
