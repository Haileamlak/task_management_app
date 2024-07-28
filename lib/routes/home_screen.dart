import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/main.dart';
import 'package:task_management_app/routes/add_task_screen.dart';
import 'package:task_management_app/routes/task_detail_screen.dart';
import 'package:task_management_app/services/task_service.dart';
import 'package:task_management_app/models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentSort = '';
  List<Task> currentTasks = [];
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Tasks'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _currentSort == ''
                              ? Colors.lightBlue
                              : Colors.grey,
                          fixedSize: const Size.fromHeight(20)),
                      onPressed: () {
                        setState(() {
                          _currentSort = '';
                        });
                      },
                      child: const Text('All'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentSort == 'Low'
                            ? Colors.lightBlue
                            : Colors.grey,
                            fixedSize: const Size.fromHeight(20)
                      ),
                      onPressed: () {
                        setState(() {
                          _currentSort = 'Low';
                        });
                      },
                      child: const Text('Low'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                          backgroundColor: _currentSort == 'Medium'
                              ? Colors.lightBlue
                              : Colors.grey,
                          fixedSize: const Size.fromHeight(20)),
                      onPressed: () {
                        setState(() {
                          _currentSort = 'Medium';
                        });
                      },
                      child: const Text('Medium'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                          backgroundColor: _currentSort == 'High'
                              ? Colors.lightBlue
                              : Colors.grey,
                          fixedSize: const Size.fromHeight(20)
                          ),
                      onPressed: () {
                        setState(() {
                          _currentSort = 'High';
                        });
                      },
                      child: const Text('High'),
                    ),
                  ),
                  
                ],
              ),
            ),
          )),
      body: Consumer<TaskService>(
        builder: (context, taskService, child) {
          return StreamBuilder<List<Task>>(
            stream: taskService.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('No tasks'),
                  ),
                );
              }
              final tasks = snapshot.data!;
              final currentTasks = tasks
                  .where((task) =>
                      _currentSort == '' || task.priority == _currentSort)
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentTasks.length,
                  itemBuilder: (context, index) {
                    final task = currentTasks[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        tileColor: task.deadline.millisecondsSinceEpoch <
                                DateTime.now().millisecondsSinceEpoch
                            ? Colors.grey
                            : task.priority == 'Low'
                                ? Colors.green[100]
                                : task.priority == 'Medium'
                                    ? Colors.yellow[100]
                                    : Colors.red[100],
                        leading: task.deadline.millisecondsSinceEpoch <
                                DateTime.now().millisecondsSinceEpoch
                            ? const Icon(Icons.task_alt)
                            : const Icon(Icons.pending_outlined),
                        title: Text(task.title),
                        subtitle: Text(
                          task.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                            DateFormat('dd/MM/yyyy').format(task.deadline)),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetailScreen(task: task),
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
