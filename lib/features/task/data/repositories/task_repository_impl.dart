import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource taskLocalDatasource;

  TaskRepositoryImpl({
    required this.taskLocalDatasource,
  });
  @override
  Future<void> addTaskToDeletedBox(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    await taskLocalDatasource.addTaskToDeletedBox(model);
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    await taskLocalDatasource.addTask(model);
  }

  @override
  Future<void> deleteAllTasks() async {
    await taskLocalDatasource.deleteAllTasks();
  }

  @override
  Future<void> deleteTasksById(String id) async {
    await taskLocalDatasource.deleteTasksById(id);
  }

  @override
  Future<List<TaskEntity>> getAllDeletedBox() async {
    return await taskLocalDatasource.getAllDeletedBox();
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    return await taskLocalDatasource.getAllTasks();
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await taskLocalDatasource.updateTask(task.id, TaskModel.fromEntity(task));
  }
}
