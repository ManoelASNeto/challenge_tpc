import 'package:hive/hive.dart';

import '../models/task_model.dart';

abstract class TaskLocalDatasource {
  Future<void> addTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<void> deleteTask(String id);
}

class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  final Box<TaskModel> box;

  TaskLocalDatasourceImpl({
    required this.box,
  });

  @override
  Future<void> addTask(TaskModel task) async {
    await box.put(task.taskId, task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await box.delete(id);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return box.values.toList();
  }
}
