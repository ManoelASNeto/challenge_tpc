import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTaskToDeletedBoxUsecase {
  TaskRepository taskRepository;

  AddTaskToDeletedBoxUsecase({
    required this.taskRepository,
  });

  Future<void> call(TaskEntity task) async {
    try {
      await taskRepository.addTaskToDeletedBox(task);
    } catch (error) {
      rethrow;
    }
  }
}
