import 'package:demo_mobx/entities/task/task.dart';
import 'package:demo_mobx/repository/remote_repository/task_repository.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart'; // This file will be generated by MobX

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final TaskRepository _repository;
  _TaskStore(this._repository);

  @observable
  List<Task> listTasks = [];

  @action
  void getListTask() {
    _repository.getListTasks().then((value) => listTasks = value);
  }
}