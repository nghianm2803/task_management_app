class Task {
  int? id;
  String title;
  String description;
  int status; // 0: Chưa hoàn thành, 1: Hoàn thành
  String dueDate;
  String createdAt;
  String updatedAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'due_date': dueDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
      dueDate: map['due_date'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
