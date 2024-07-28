import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_management_app/main.dart';
import 'package:task_management_app/models/task.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskService with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromDocument(doc)).toList());
  }

  Future<void> addTask(Task task) async {
    DocumentReference docRef = await _db.collection('tasks').add(task.toMap());
    _scheduleNotification(task, docRef.id);
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
    _scheduleNotification(task, task.id);
  }

  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
    await flutterLocalNotificationsPlugin.cancel(id.hashCode);
  }

  void _scheduleNotification(Task task, String taskId) {
    final scheduledDate = task.deadline.subtract(const Duration(minutes: 10));

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.zonedSchedule(
      taskId.hashCode,
      'Task Reminder',
      'Your task "${task.title}" is due soon!',
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
