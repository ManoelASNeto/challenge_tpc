import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> addTaskToDeletedBox(TaskEntity task);
  Future<void> addTask(TaskEntity task);
  Future<void> deleteAllTasks();
  Future<void> deleteTasksById(String id);
  Future<List<TaskEntity>> getAllTasks();
  Future<List<TaskEntity>> getAllDeletedBox();
  Future<void> updateTask(TaskEntity task);
}
