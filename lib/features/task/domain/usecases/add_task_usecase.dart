import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTaskUsecase {
  final TaskRepository taskRepository;
  AddTaskUsecase({
    required this.taskRepository,
  });

  Future<void> call(TaskEntity task) async {
    try {
      await taskRepository.addTask(task);
    } catch (error) {
      rethrow;
    }
  }
}
