import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/add_task_to_deleted_box_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late AddTaskToDeletedBoxUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = AddTaskToDeletedBoxUsecase(taskRepository: mockTaskRepository);
  });

  test('should call addTaskToDeletedBox on the repository', () async {
    const task = TaskEntity(id: '1', title: 'Test Task', isDone: false);
    when(() => mockTaskRepository.addTaskToDeletedBox(task)).thenAnswer((_) async => {});

    await usecase.call(task);

    verify(() => mockTaskRepository.addTaskToDeletedBox(task)).called(1);
  });
}
