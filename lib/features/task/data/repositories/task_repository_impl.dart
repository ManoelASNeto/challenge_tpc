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
  Future<void> addTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    await taskLocalDatasource.addTask(model);
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskLocalDatasource.deleteTask(id);
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    return await taskLocalDatasource.getAllTasks();
  }
}
