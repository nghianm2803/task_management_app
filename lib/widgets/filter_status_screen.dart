import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';

class FilterStatusScreen extends StatelessWidget {
  final Function(String) onSelected;
  final String selectedValue;

  const FilterStatusScreen({
    Key? key,
    required this.onSelected,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                Text("Filter by Status", style: text18w600gray900),
                const Icon(Icons.done, color: Colors.transparent),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.gray200,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: const Text("All", style: TextStyle(fontSize: 16)),
                      trailing: selectedValue == "all"
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        onSelected("all");
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.gray200,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: const Text("Completed",
                          style: TextStyle(fontSize: 16)),
                      trailing: selectedValue == "completed"
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        onSelected("completed");
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Incomplete",
                        style: TextStyle(fontSize: 16)),
                    trailing: selectedValue == "incomplete"
                        ? const Icon(Icons.check, color: AppColors.blue500)
                        : null,
                    onTap: () {
                      onSelected("incomplete");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
