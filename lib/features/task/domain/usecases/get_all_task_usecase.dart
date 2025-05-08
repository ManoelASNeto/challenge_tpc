import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetAllTaskUsecase {
  TaskRepository taskRepository;
  GetAllTaskUsecase({
    required this.taskRepository,
  });

  Future<List<TaskEntity>> call() async {
    try {
      return await taskRepository.getAllTasks();
    } catch (error) {
      rethrow;
    }
  }
}
