import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;

  const TaskDetailScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskController taskController = Get.find<TaskController>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = DateTime.tryParse(widget.task!.dueDate);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? "Add Task" : "Update Task",
          style: text20w600gray900,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    backgroundColor: AppColors.gray100,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_sharp,
                        size: 22,
                        color: AppColors.green300,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _dueDate == null
                            ? "Today"
                            : DateFormat('dd/MM/yyyy').format(_dueDate!),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
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
}
