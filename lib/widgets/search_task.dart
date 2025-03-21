import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/values/app_colors.dart';

class SearchTask extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController searchController = TextEditingController();
  SearchTask({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Obx(
      () => TextField(
        cursorColor: AppColors.green500,
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search tasks...",
          prefixIcon: const Icon(Icons.search, color: AppColors.gray500),
          suffixIcon: taskController.searchText.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    taskController.searchTasks("");
                  },
                  child: const Icon(Icons.clear, color: Colors.grey))
              : null,
          filled: true,
          fillColor: isDarkMode ? AppColors.gray700 : AppColors.gray100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.gray300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.gray500, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.gray300),
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
