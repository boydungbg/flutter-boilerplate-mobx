import 'package:mix_tube_application/entities/task/task.dart';
import 'package:dio/dio.dart';

class TaskRepository {
  final Dio _resClient;
  final String _path = 'tasks';
  TaskRepository(this._resClient);

  Future<List<Task>> getListTasks() async {
    return await _resClient.get(_path).then((value) {
      return List.from(value.data as List)
          .map((e) => Task.fromJson(e))
          .cast<Task>()
          .toList();
    });
  }
}
