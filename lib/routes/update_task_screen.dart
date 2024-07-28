// update task detail screen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/services/task_service.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;
  const UpdateTaskScreen({super.key, required this.task});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _priorityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _deadlineController.text = widget.task.deadline.toString();
    _priorityController.text = widget.task.priority.toString();
  }

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
                  decoration: const InputDecoration(labelText: 'Update Title'),
                  validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Update Description'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a description' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _deadlineController,
                  decoration: InputDecoration(
                      labelText: 'Update Deadline',
                      suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: widget.task.deadline,
                              firstDate: DateTime.now().microsecondsSinceEpoch <
                                      widget
                                          .task.deadline.microsecondsSinceEpoch
                                  ? DateTime.now()
                                  : widget.task.deadline,
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
                      const InputDecoration(labelText: 'Update Priority'),
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
                          id: widget.task.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          deadline: DateTime.parse(_deadlineController.text),
                          priority: _priorityController.text,
                        );
                        Provider.of<TaskService>(context, listen: false)
                            .updateTask(task);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update Task'),
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
