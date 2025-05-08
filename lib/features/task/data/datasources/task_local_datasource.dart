import 'package:hive/hive.dart';

import '../models/task_model.dart';

abstract class TaskLocalDatasource {
  Future<void> addTask(TaskModel task);
  Future<void> addTaskToDeletedBox(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<void> updateTask(String id, TaskModel task);
  Future<List<TaskModel>> getAllDeletedBox();
  Future<void> deleteAllTasks();
  Future<void> deleteTasksById(String id);
}

class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  final Box<TaskModel> tasksBox;
  final Box<TaskModel> deletedTasksBox;
  TaskLocalDatasourceImpl({
    required this.tasksBox,
    required this.deletedTasksBox,
  });

  @override
  Future<void> addTaskToDeletedBox(TaskModel task) async {
    await deletedTasksBox.put(task.taskId, task);
    await tasksBox.delete(task.id);
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await tasksBox.put(task.taskId, task);
  }

  @override
  Future<void> deleteAllTasks() async {
    await deletedTasksBox.clear();
  }

  @override
  Future<void> deleteTasksById(String id) async {
    await deletedTasksBox.delete(id);
  }

  @override
  Future<List<TaskModel>> getAllDeletedBox() async {
    return deletedTasksBox.values.toList();
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return tasksBox.values.toList();
  }

  @override
  Future<void> updateTask(String id, TaskModel task) async {
    await tasksBox.put(id, task);
  }
}
