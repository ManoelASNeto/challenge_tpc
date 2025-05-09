import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUsecase {
  TaskRepository taskRepository;
  UpdateTaskUsecase({
    required this.taskRepository,
  });

  Future<void> call(TaskEntity task) async {
    try {
      await taskRepository.updateTask(task);
    } catch (error) {
      rethrow;
    }
  }
}
