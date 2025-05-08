import '../repositories/task_repository.dart';

class DeletedAllTasksUsecase {
  TaskRepository taskRepository;
  DeletedAllTasksUsecase({
    required this.taskRepository,
  });

  Future<void> call() async {
    try {
      await taskRepository.deleteAllTasks();
    } catch (error) {
      rethrow;
    }
  }
}
