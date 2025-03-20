import 'package:get/get.dart';
import 'package:task_management_app/core/model/task_model.dart';
import 'package:task_management_app/core/services/database_service.dart';
import 'package:task_management_app/core/values/app_colors.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  RxList<Task> filteredTasks = <Task>[].obs;

  final RxString filterBy = 'all'.obs;
  final RxString sortBy = 'oldest'.obs;

  final _searchText = "".obs;
  String get searchText => _searchText.value;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks({bool incompleteOnly = false}) async {
    final db = DatabaseService.instance;
    final fetchedTasks = await db.getTasks(incomplete: incompleteOnly);
    tasks.assignAll(fetchedTasks);
    filteredTasks.assignAll(fetchedTasks);
  }

  void saveTask(
      {int? id,
      required String title,
      String? description,
      DateTime? dueDate}) async {
    if (title.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập tiêu đề",
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
      createdAt: id == null
          ? DateTime.now().toIso8601String()
          : tasks.firstWhere((t) => t.id == id).createdAt,
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
      filteredTasks.sort((a, b) =>
          DateTime.parse(a.dueDate).compareTo(DateTime.parse(b.dueDate)));
    } else if (value == "newest") {
      filteredTasks.sort((a, b) =>
          DateTime.parse(b.dueDate).compareTo(DateTime.parse(a.dueDate)));
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
        tasks
            .where((task) =>
                task.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
    update();
  }
}
