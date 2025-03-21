import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/common_widget/keyboard_dismisser.dart';
import 'package:task_management_app/core/controller/task_controller.dart';
import 'package:task_management_app/core/utils/app_helper.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';
import 'package:task_management_app/generated/assets.gen.dart';
import 'package:task_management_app/screens/task_detail_screen.dart';
import 'package:task_management_app/widgets/confirm_dialog.dart';
import 'package:task_management_app/widgets/search_task.dart';
import 'package:task_management_app/widgets/view_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? colorScheme.background : AppColors.white,
        appBar: AppBar(
          title: Text("Task Management", style: Get.isDarkMode ? text20w600white : text20w600gray900),
          backgroundColor: Get.isDarkMode ? AppColors.gray900 : AppColors.white,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis),
              color: Get.isDarkMode ? Colors.white : AppColors.gray900,
              onPressed: () {
                Get.bottomSheet(ViewBottomSheet(), isScrollControlled: true);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchTask(),
            ),
            Expanded(
              child: Obx(() {
                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: Image.asset(
                            Assets.images.emptyData.path,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("You're all done!", style: Get.isDarkMode ? text18w600white : text18w600gray900),
                        Text(
                          "Enjoy the rest of your day.",
                          style: Get.isDarkMode ? text14w400white : text14w400gray600,
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
                        return await showCupertinoDialog(context: context, builder: (BuildContext context) => DeleteConfirmDialog(task: task));
                      },
                      onDismissed: (direction) {
                        taskController.deleteTask(task.id!);
                        Get.back();
                        Get.back();
                      },
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TaskDetailScreen(task: task));
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: const CircleBorder(),
                                          fillColor: MaterialStateProperty.resolveWith((states) {
                                            if (states.contains(MaterialState.selected)) {
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
                                              color: Get.isDarkMode ? AppColors.gray300 : AppColors.gray900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration: task.status == 1 ? TextDecoration.lineThrough : null)),
                                      task.description.isNotEmpty
                                          ? Text(task.description,
                                              style: TextStyle(
                                                color: Get.isDarkMode ? AppColors.gray400 : AppColors.gray500,
                                              ))
                                          : const SizedBox.shrink(),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.calendar,
                                            size: 14,
                                            color: task.status == 1
                                                ? (Get.isDarkMode ? AppColors.gray400 : AppColors.gray500)
                                                : (Get.isDarkMode ? AppColors.gray400 : AppColors.red400),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            AppHelper.formatDate(task.dueDate),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: task.status == 1 ? (Get.isDarkMode ? AppColors.gray400 : AppColors.gray500) : AppColors.red400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (index < taskController.filteredTasks.length - 1)
                                const Divider(
                                  color: AppColors.gray300,
                                  thickness: 0.5,
                                  indent: 40,
                                ),
                            ],
                          ),
                        ),
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
}
