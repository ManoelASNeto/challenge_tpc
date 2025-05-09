import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_tasks_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeletedTasksByIdUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeletedTasksByIdUsecase(taskRepository: mockTaskRepository);
  });

  test('should call deleteTasksById on the repository', () async {
    const taskId = '1';
    when(() => mockTaskRepository.deleteTasksById(taskId)).thenAnswer((_) async => {});

    await usecase.call(taskId);

    verify(() => mockTaskRepository.deleteTasksById(taskId)).called(1);
  });
}
