import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';

import '../repositories/task_repository.dart';

class TaskUsecase {
  final TaskRepository taskRepository;

  TaskUsecase({
    required this.taskRepository,
  });

  Future<void> add(TaskEntity task) async {
    try {
      await taskRepository.addTask(task);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskEntity>> getAllTasks() async {
    try {
      return await taskRepository.getAllTasks();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await taskRepository.deleteTask(id);
    } catch (error) {
      rethrow;
    }
  }
}
