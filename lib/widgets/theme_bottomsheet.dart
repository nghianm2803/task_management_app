import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Obx(() {
        final isDarkMode = controller.themeMode.value == ThemeMode.dark;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.gray900 : AppColors.gray100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.done, color: Colors.transparent),
                  Text(
                    "Theme",
                    style: isDarkMode ? text18w600white : text18w600gray900,
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Done", style: text16w600green400),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildThemeOption(
                title: "Light",
                isSelected: controller.themeMode.value == ThemeMode.light,
                color: Colors.white,
                onTap: () => controller.updateTheme(false),
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                title: "Dark",
                isSelected: controller.themeMode.value == ThemeMode.dark,
                color: AppColors.gray800,
                onTap: () => controller.updateTheme(true),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.grey.withOpacity(0.5) : Colors.transparent,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                color: title == "Light" ? AppColors.gray100 : AppColors.gray900,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: title == "Light" ? AppColors.gray900 : Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      width: 200,
                      height: 6,
                      color: title == "Light" ? AppColors.gray900 : AppColors.gray300,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 6,
                        width: 100,
                        color: title == "Light" ? AppColors.gray500 : AppColors.gray400,
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: AppColors.green500),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
