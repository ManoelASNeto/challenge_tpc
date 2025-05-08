import '../repositories/task_repository.dart';

class DeletedTasksByIdUsecase {
  TaskRepository taskRepository;
  DeletedTasksByIdUsecase({
    required this.taskRepository,
  });

  Future<void> call(String id) async {
    try {
      await taskRepository.deleteTasksById(id);
    } catch (error) {
      rethrow;
    }
  }
}
