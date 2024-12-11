import 'package:flutter/material.dart';
import 'package:todo_final_project/ui/components/custom_icon.dart';
import 'package:todo_final_project/ui/dialog_utils.dart';
import 'package:todo_final_project/ui/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo_final_project/providers/task_provider.dart';
import 'package:todo_final_project/ui/views/edit_task/edit_task_view_body.dart';

class EditTaskView extends StatefulWidget {
  static const String routeName = 'EditTaskView';

  const EditTaskView({super.key});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late Task taskModel;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    taskModel = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Task"),
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
        toolbarTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomIcon(
              icon: Icons.done,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateTask();
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 65),
        child: EditTaskViewBody(
          taskModel: taskModel,
          formKey: _formKey,
        ),
      ),
    );
  }

  void updateTask() {

    Provider.of<TaskProvider>(context, listen: false).fetchAllNotes();

    DialogUtils.showToast(context, 'Task updated successfully');

    Navigator.pop(context);
  }
}