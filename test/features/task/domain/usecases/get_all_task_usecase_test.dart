import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetAllTaskUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = GetAllTaskUsecase(taskRepository: mockTaskRepository);
  });

  test('should call getAllTasks on the repository and return a list of tasks', () async {
    final tasks = [
      const TaskEntity(id: '1', title: 'Task 1', isDone: false),
      const TaskEntity(id: '2', title: 'Task 2', isDone: true),
    ];
    when(() => mockTaskRepository.getAllTasks()).thenAnswer((_) async => tasks);

    final result = await usecase.call();

    expect(result, tasks);
    verify(() => mockTaskRepository.getAllTasks()).called(1);
  });
}
