import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/services/database_service.dart';
import 'package:task_management_app/core/values/app_colors.dart';
import 'package:task_management_app/core/values/app_constant.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  RxList<Task> filteredTasks = <Task>[].obs;

  final RxString filterBy = 'all'.obs;
  final RxString sortBy = 'oldest'.obs;

  final _searchText = "".obs;
  String get searchText => _searchText.value;

  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  RxBool isDarkMode = false.obs;

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(SharePrefKeys.keyTheme) ?? 'light';

    isDarkMode.value = savedTheme == 'dark';
    themeMode.value = isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  void updateTheme(bool isDark) async {
    isDarkMode.value = isDark;
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharePrefKeys.keyTheme, isDark ? 'dark' : 'light');

    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadTheme();
    fetchTasks();
  }

  void fetchTasks({bool incompleteOnly = false}) async {
    final db = DatabaseService.instance;
    final fetchedTasks = await db.getTasks(incomplete: incompleteOnly);
    tasks.assignAll(fetchedTasks);
    filteredTasks.assignAll(fetchedTasks);
  }

  void saveTask({int? id, required String title, String? description, DateTime? dueDate}) async {
    if (title.isEmpty) {
      Get.snackbar(
        "Error",
        "Please title can not be empty",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red200,
        borderColor: AppColors.red500,
        borderWidth: 0.5,
        colorText: AppColors.red900,
      );
      return;
    }

    dueDate ??= DateTime.now();

    Task task = Task(
      id: id,
      title: title,
      description: description ?? "",
      status: id == null ? 0 : tasks.firstWhere((t) => t.id == id).status,
      dueDate: dueDate.toIso8601String(),
      createdAt: id == null ? DateTime.now().toIso8601String() : tasks.firstWhere((t) => t.id == id).createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );

    if (id == null) {
      await DatabaseService.instance.addTask(task);
    } else {
      await DatabaseService.instance.updateTask(task);
    }

    fetchTasks();

    Future.delayed(const Duration(milliseconds: 100), () {
      Get.snackbar(
        "Success",
        id == null ? "Task added successfully" : "Task updated successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.success100,
        borderColor: AppColors.green500,
        borderWidth: 0.5,
        colorText: AppColors.green500,
      );
    });

    Get.back();
    Get.back();
  }

  void addTask(Task task) async {
    final db = DatabaseService.instance;
    await db.addTask(task);
    fetchTasks();
  }

  void updateTask(Task task) async {
    final db = DatabaseService.instance;
    await db.updateTask(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    final db = DatabaseService.instance;
    await db.deleteTask(id);
    fetchTasks();
    Get.snackbar(
      "Delete success",
      "Deleted task successfully",
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.red200,
      borderColor: AppColors.red500,
      borderWidth: 0.5,
      colorText: AppColors.red900,
    );
  }

  void sortTasks(String value) {
    sortBy.value = value;
    if (value == "oldest") {
      filteredTasks.sort((a, b) => DateTime.parse(a.dueDate).compareTo(DateTime.parse(b.dueDate)));
    } else if (value == "newest") {
      filteredTasks.sort((a, b) => DateTime.parse(b.dueDate).compareTo(DateTime.parse(a.dueDate)));
    }
    update();
  }

  void filterTasks(String filterBy) {
    if (filterBy == "all") {
      filteredTasks.assignAll(tasks);
    } else if (filterBy == "completed") {
      filteredTasks.assignAll(tasks.where((task) => task.status == 1).toList());
    } else if (filterBy == "incomplete") {
      filteredTasks.assignAll(tasks.where((task) => task.status == 0).toList());
    }
    update();
  }

  void searchTasks(String query) {
    _searchText.value = query;

    if (query.isEmpty) {
      filteredTasks.assignAll(tasks);
    } else {
      filteredTasks.assignAll(
        tasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
    update();
  }

  void duplicateTask(Task task) {
    final newTask = Task(
      title: task.title,
      description: task.description,
      status: 0,
      dueDate: task.dueDate,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    addTask(newTask);
    Get.snackbar(
      "Success",
      "Task duplicated successfully!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.success100,
      borderColor: AppColors.green500,
      borderWidth: 0.5,
      colorText: AppColors.green500,
    );
  }

  Future<void> resetAll() async {
    sortBy.value = "oldest";
    filterBy.value = "all";
    updateTheme(false);
    fetchTasks();
    filteredTasks.assignAll(tasks);
    sortTasks("oldest");
    update();
  }
}
