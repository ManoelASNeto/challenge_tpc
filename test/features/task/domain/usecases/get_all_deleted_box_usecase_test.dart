import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:challenge_tpc/features/task/domain/repositories/task_repository.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_deleted_box_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetAllDeletedBoxUsecase usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = GetAllDeletedBoxUsecase(taskRepository: mockTaskRepository);
  });

  test('should call getAllDeletedBox on the repository and return a list of tasks', () async {
    final tasks = [
      const TaskEntity(id: '1', title: 'Deleted Task 1', isDone: false),
      const TaskEntity(id: '2', title: 'Deleted Task 2', isDone: true),
    ];
    when(() => mockTaskRepository.getAllDeletedBox()).thenAnswer((_) async => tasks);

    final result = await usecase.call();

    expect(result, tasks);
    verify(() => mockTaskRepository.getAllDeletedBox()).called(1);
  });
}
