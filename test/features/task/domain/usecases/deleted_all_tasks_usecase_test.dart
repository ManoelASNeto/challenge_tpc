import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_all_tasks_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeletedAllTasksUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeletedAllTasksUsecase(taskRepository: mockTaskRepository);
  });

  test('should call deleteAllTasks on the repository', () async {
    when(() => mockTaskRepository.deleteAllTasks()).thenAnswer((_) async => {});

    await usecase.call();

    verify(() => mockTaskRepository.deleteAllTasks()).called(1);
  });
}
