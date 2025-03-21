import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/values/text_styles.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final Task task;

  const DeleteConfirmDialog({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text("Delete task?"),
            content: Text("Are you sure you want to delete the task '${task.title}'?"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel", style: Get.isDarkMode ? text16w400gray500 : text16w400gray900),
              ),
              CupertinoDialogAction(
                onPressed: () => {
                  taskController.deleteTask(task.id!),
                  Get.back(),
                  Get.back(),
                  Get.back(),
                },
                isDestructiveAction: true,
                child: Text("Delete", style: text16w500red500),
              ),
            ],
          )
        : AlertDialog(
            title: const Text("Delete task?"),
            content: Text("Are you sure you want to delete the task '${task.title}'?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel", style: Get.isDarkMode ? text16w400gray500 : text16w400gray900),
              ),
              TextButton(
                onPressed: () => {
                  taskController.deleteTask(task.id!),
                  Get.back(),
                  Get.back(),
                  Get.back(),
                },
                child: Text("Delete", style: text16w500red500),
              ),
            ],
          );
  }
}
