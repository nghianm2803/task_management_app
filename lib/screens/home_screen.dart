import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/common_widget/keyboard_dismisser.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/utils/app_helper.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';
import 'package:task_management_app/screens/task_detail_screen.dart';
import 'package:task_management_app/widgets/setting_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text("Task Management", style: text20w600gray900),
          backgroundColor: AppColors.white,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis),
              onPressed: () {
                Get.bottomSheet(SettingBottomSheet(), isScrollControlled: true);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildSearchField(),
            ),
            Expanded(
              child: Obx(() {
                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You're all done!", style: text18w600gray900),
                        Text(
                          "Enjoy the rest of your day.",
                          style: text14w400gray600,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: taskController.filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.filteredTasks[index];

                    return Dismissible(
                      key: Key(task.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: AppColors.red200,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await _showDeleteConfirmDialog(context, task);
                      },
                      onDismissed: (direction) {
                        taskController.deleteTask(task.id!);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => TaskDetailScreen(task: task));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: const CircleBorder(),
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors.green500;
                                          }
                                          return AppColors.gray100;
                                        }),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: task.status == 1,
                                      onChanged: (value) {
                                        task.status = value! ? 1 : 0;
                                        taskController.updateTask(task);
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(task.title,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            decoration: task.status == 1
                                                ? TextDecoration.lineThrough
                                                : null)),
                                    task.description.isNotEmpty
                                        ? Text(task.description,
                                            style: const TextStyle(
                                                color: AppColors.gray500))
                                        : const SizedBox.shrink(),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.calendar,
                                          size: 16,
                                          color: task.status == 1
                                              ? AppColors.gray500
                                              : AppColors.red400,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          AppHelper.formatDate(task.dueDate),
                                          style: TextStyle(
                                              color: task.status == 1
                                                  ? AppColors.gray500
                                                  : AppColors.red400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (index < taskController.filteredTasks.length - 1)
                            const Divider(
                              color: AppColors.gray300,
                              thickness: 0.5,
                              indent: 40,
                            ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: GradientColors.gradientGreen,
          ),
          padding: const EdgeInsets.all(4),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Get.to(() => const TaskDetailScreen());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Obx(
      () => TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search tasks...",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: taskController.searchText.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    taskController.searchTasks("");
                  },
                  child: const Icon(Icons.clear, color: Colors.grey))
              : null,
          filled: true,
          fillColor: AppColors.gray100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
        ),
        onChanged: (value) {
          taskController.searchTasks(value);
        },
      ),
    );
  }
}

Future<bool?> _showDeleteConfirmDialog(BuildContext context, Task task) {
  if (Platform.isIOS) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Delete task?"),
        content:
            Text("Are you sure you want to delete the task '${task.title}'?"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel", style: text16w400gray900),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            isDestructiveAction: true,
            child: Text("Delete", style: text16w500red500),
          ),
        ],
      ),
    );
  } else {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete task?"),
        content:
            Text("Are you sure you want to delete the task '${task.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel", style: text16w400gray900),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Delete", style: text16w500red500),
          ),
        ],
      ),
    );
  }
}
