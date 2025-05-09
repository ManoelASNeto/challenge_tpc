import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetAllDeletedBoxUsecase {
  TaskRepository taskRepository;
  GetAllDeletedBoxUsecase({
    required this.taskRepository,
  });

  Future<List<TaskEntity>> call() async {
    try {
      return await taskRepository.getAllDeletedBox();
    } catch (error) {
      rethrow;
    }
  }
}
