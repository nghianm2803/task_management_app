import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';
import 'package:task_management_app/widgets/filter_status_screen.dart';
import 'package:task_management_app/widgets/theme_bottomsheet.dart';

class ViewBottomSheet extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  ViewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.gray900 : AppColors.gray100,
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
                Text("View", style: Get.isDarkMode ? text18w600white : text18w600gray900),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Done", style: text16w600green400),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Sort", style: Get.isDarkMode ? text14w500gray400 : text14w500gray500),
              ),
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(color: Get.isDarkMode ? AppColors.gray50 : Colors.white, borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text("Sort by", style: Get.isDarkMode ? text14w500gray400 : text14w500gray900),
                  subtitle: Text(taskController.sortBy.value, style: const TextStyle(color: AppColors.gray500)),
                  leading: const Icon(CupertinoIcons.arrow_up_arrow_down),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    String newSort = (taskController.sortBy.value == "oldest") ? "newest" : "oldest";
                    taskController.sortTasks(newSort);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Filter", style: Get.isDarkMode ? text14w500gray400 : text14w500gray500),
              ),
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(color: Get.isDarkMode ? AppColors.gray50 : Colors.white, borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text("Status", style: Get.isDarkMode ? text14w500gray400 : text14w500gray900),
                  subtitle: Text(taskController.filterBy.value, style: const TextStyle(color: AppColors.gray500)),
                  leading: const Icon(CupertinoIcons.slider_horizontal_3),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.back();
                    Get.bottomSheet(
                      FilterStatusScreen(
                        onSelected: (value) {
                          taskController.filterBy.value = value;
                          taskController.filterTasks(value);
                        },
                        initialValue: taskController.filterBy.value,
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text("Appearance", style: Get.isDarkMode ? text14w500gray400 : text14w500gray500),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Get.isDarkMode ? AppColors.gray50 : Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text("Current theme", style: Get.isDarkMode ? text14w500gray400 : text14w500gray900),
                subtitle: Text(Get.isDarkMode ? "Dark" : "Light", style: const TextStyle(color: AppColors.gray500)),
                leading: const Icon(
                  Icons.palette_outlined,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.back();
                  Get.bottomSheet(
                    const ThemeBottomSheet(),
                    isScrollControlled: true,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => taskController.resetAll(),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Get.isDarkMode ? AppColors.gray50 : Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Reset all",
                  style: text16w500green500,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
