import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';
import 'package:task_management_app/widgets/filter_status_screen.dart';

class SettingBottomSheet extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel", style: text16w500red500),
                ),
                Text("Sort & filter", style: text18w600gray900),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Done", style: text16w600green400),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Sort", style: text14w500gray500),
              ),
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: const Text("Sort by", style: TextStyle(fontSize: 16)),
                  subtitle: Text(taskController.sortBy.value,
                      style: const TextStyle(color: AppColors.gray500)),
                  leading: const Icon(CupertinoIcons.arrow_up_arrow_down),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    String newSort = (taskController.sortBy.value == "oldest")
                        ? "newest"
                        : "oldest";
                    taskController.sortTasks(newSort);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Filter", style: text14w500gray500),
              ),
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: const Text("Status", style: TextStyle(fontSize: 16)),
                  subtitle: Text(taskController.filterBy.value,
                      style: const TextStyle(color: AppColors.gray500)),
                  leading: const Icon(CupertinoIcons.slider_horizontal_3),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.back();
                    Get.bottomSheet(
                      FilterStatusScreen(
                        onSelected: (value) {
                          taskController.filterBy.value = value;
                          taskController
                              .filterTasks(taskController.filterBy.value);
                          Get.back();
                        },
                        selectedValue: taskController.filterBy.value,
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Appearance", style: text14w500gray500),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title:
                    const Text("Current theme", style: TextStyle(fontSize: 16)),
                subtitle: Text(Get.isDarkMode ? "Dark" : "Light",
                    style: const TextStyle(color: AppColors.gray500)),
                leading: Icon(
                  Get.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Get.isDarkMode ? AppColors.black : AppColors.orange500,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
