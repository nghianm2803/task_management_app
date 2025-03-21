import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/utils/app_helper.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';
import 'package:task_management_app/widgets/confirm_dialog.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;

  const TaskDetailScreen({super.key, this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskController taskController = Get.find<TaskController>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String? _updateAt;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = DateTime.tryParse(widget.task!.dueDate);
      _updateAt = AppHelper.formatDate(widget.task!.updatedAt);
    }
  }

  void _saveTask() {
    taskController.saveTask(
      id: widget.task?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _dueDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? "Add Task" : "Update Task",
          style: isDarkMode ? text20w600white : text20w600gray900,
        ),
        backgroundColor: Get.isDarkMode ? AppColors.gray900 : AppColors.white,
        actions: [
          if (widget.task != null)
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis),
              color: Get.isDarkMode ? Colors.white : AppColors.gray900,
              onPressed: () => _showTaskOptions(context, widget.task!),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: AppColors.green500,
              controller: _titleController,
              decoration: InputDecoration(
                labelText: null,
                label: RichText(
                  text: TextSpan(
                    text: 'Title',
                    style: TextStyle(color: Get.isDarkMode ? AppColors.white : AppColors.gray900),
                    children: const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray500, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray300),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: AppColors.green500,
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Get.isDarkMode ? AppColors.white : AppColors.gray900),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray500, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.gray300),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            if (widget.task != null && _updateAt != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Last updated: $_updateAt",
                  style: Get.isDarkMode ? text14w400gray400 : text14w400gray500,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dueDate = pickedDate;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    backgroundColor: AppColors.gray50,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 22,
                        color: AppColors.green300,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _dueDate == null ? "Today" : DateFormat('dd/MM/yyyy').format(_dueDate!),
                        style: text14w400gray900,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  onPressed: _saveTask,
                  child: Text(
                    "Save",
                    style: text14w600white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskOptions(BuildContext context, Task task) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              taskController.duplicateTask(task);
              Get.back();
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.doc_on_doc,
                  color: Get.isDarkMode ? AppColors.white : AppColors.gray500,
                ),
                Text(
                  "Duplicate Task",
                  style: Get.isDarkMode ? text16w500white : text16w500gray500,
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              await showCupertinoDialog(context: context, builder: (BuildContext context) => DeleteConfirmDialog(task: task));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.delete,
                  color: AppColors.red500,
                ),
                Text(
                  "Delete Task",
                  style: text16w500red500,
                ),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Get.back(),
          child: Text("Cancel", style: Get.isDarkMode ? text16w500white : text16w500gray900),
        ),
      ),
    );
  }
}
