import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_final_project/ui/constants.dart';
import 'package:todo_final_project/ui/models/task.dart';

class TaskProvider extends ChangeNotifier{

  List<Task> tasks = [];

  void fetchAllNotes() {
  final notesBox = Hive.box<Task>(kTasksBox);
  tasks = notesBox.values.toList();
  notifyListeners();
  }

  Future<void> addTask(Task task) async {
  final notesBox = Hive.box<Task>(kTasksBox);
  await notesBox.add(task);
  tasks.add(task); // Update local list
  notifyListeners(); // Notify listeners of the change
  }




}