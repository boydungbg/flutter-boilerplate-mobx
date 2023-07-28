import 'package:demo_mobx/entities/task/task.dart';
import 'package:dio/dio.dart';

class TaskRepository {
  final Dio resClient;
  final String _path = 'tasks';
  TaskRepository({required this.resClient});

  Future<List<Task>> getListTasks() async {
    return await resClient.get(_path).then((value) {
      return List.from(value.data as List)
          .map((e) => Task.fromJson(e))
          .cast<Task>()
          .toList();
    });
  }
}
