import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/text_styles.dart';

class FilterStatusScreen extends StatefulWidget {
  final Function(String) onSelected;
  final String initialValue;

  const FilterStatusScreen({
    super.key,
    required this.onSelected,
    required this.initialValue,
  });

  @override
  _FilterStatusScreenState createState() => _FilterStatusScreenState();
}

class _FilterStatusScreenState extends State<FilterStatusScreen> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  void _selectValue(String value) {
    setState(() {
      selectedValue = value;
    });
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
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
                Text("Filter by Status", style: Get.isDarkMode ? text18w600white : text18w600gray900),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Done", style: text16w600green400),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? AppColors.gray50 : AppColors.white,
              ),
              child: Column(
                children: [
                  _buildFilterTile("All", "all"),
                  _buildFilterTile("Completed", "completed"),
                  _buildFilterTile("Incomplete", "incomplete"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTile(String title, String value) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray200,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(title, style: Get.isDarkMode ? text16w500gray500 : text16w500gray900),
        trailing: selectedValue == value ? const Icon(Icons.check, color: AppColors.blue500) : null,
        onTap: () => _selectValue(value),
      ),
    );
  }
}
