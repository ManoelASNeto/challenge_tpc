import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/update_task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = UpdateTaskUsecase(taskRepository: mockTaskRepository);
  });

  test('should call updateTask on the repository', () async {
    const task = TaskEntity(id: '1', title: 'Updated Task', isDone: true);
    when(() => mockTaskRepository.updateTask(task)).thenAnswer((_) async => {});

    await usecase.call(task);

    verify(() => mockTaskRepository.updateTask(task)).called(1);
  });
}
