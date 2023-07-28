// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$listTasksAtom =
      Atom(name: '_TaskStore.listTasks', context: context);

  @override
  List<Task> get listTasks {
    _$listTasksAtom.reportRead();
    return super.listTasks;
  }

  @override
  set listTasks(List<Task> value) {
    _$listTasksAtom.reportWrite(value, super.listTasks, () {
      super.listTasks = value;
    });
  }

  late final _$_TaskStoreActionController =
      ActionController(name: '_TaskStore', context: context);

  @override
  void getListTask() {
    final _$actionInfo = _$_TaskStoreActionController.startAction(
        name: '_TaskStore.getListTask');
    try {
      return super.getListTask();
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listTasks: ${listTasks}
    ''';
  }
}
