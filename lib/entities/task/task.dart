class Task {
  final String? id;
  final String? createdAt;
  final String? title;
  final bool? status;

  Task({this.id, this.createdAt, this.title, this.status});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json['id'],
      createdAt: json['createdAt'],
      title: json['title'],
      status: json['status']);
}
