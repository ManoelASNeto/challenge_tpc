import 'package:challenge_tpc/features/task/data/datasources/task_local_datasource.dart';
import 'package:challenge_tpc/features/task/data/models/task_model.dart';
import 'package:challenge_tpc/features/task/data/repositories/task_repository_impl.dart';
import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskLocalDatasource extends Mock implements TaskLocalDatasource {}

void main() {
  late MockTaskLocalDatasource mockTaskLocalDatasource;
  late TaskRepositoryImpl repository;

  setUp(() {
    mockTaskLocalDatasource = MockTaskLocalDatasource();
    repository = TaskRepositoryImpl(taskLocalDatasource: mockTaskLocalDatasource);
  });

  group('TaskRepositoryImpl', () {
    const taskEntity = TaskEntity(id: '1', title: 'Test Task', isDone: false);
    final taskModel = TaskModel.fromEntity(taskEntity);

    test('should add a task to the deleted box', () async {
      when(() => mockTaskLocalDatasource.addTaskToDeletedBox(taskModel)).thenAnswer((_) async => {});

      await repository.addTaskToDeletedBox(taskEntity);

      verify(() => mockTaskLocalDatasource.addTaskToDeletedBox(taskModel)).called(1);
    });

    test('should add a task', () async {
      when(() => mockTaskLocalDatasource.addTask(taskModel)).thenAnswer((_) async => {});

      await repository.addTask(taskEntity);

      verify(() => mockTaskLocalDatasource.addTask(taskModel)).called(1);
    });

    test('should delete all tasks', () async {
      when(() => mockTaskLocalDatasource.deleteAllTasks()).thenAnswer((_) async => {});

      await repository.deleteAllTasks();

      verify(() => mockTaskLocalDatasource.deleteAllTasks()).called(1);
    });

    test('should delete a task by id', () async {
      const taskId = '1';
      when(() => mockTaskLocalDatasource.deleteTasksById(taskId)).thenAnswer((_) async => {});

      await repository.deleteTasksById(taskId);

      verify(() => mockTaskLocalDatasource.deleteTasksById(taskId)).called(1);
    });

    test('should return all deleted tasks', () async {
      final tasks = [taskModel];
      when(() => mockTaskLocalDatasource.getAllDeletedBox()).thenAnswer((_) async => tasks);

      final result = await repository.getAllDeletedBox();

      expect(result, tasks);
      verify(() => mockTaskLocalDatasource.getAllDeletedBox()).called(1);
    });

    test('should return all tasks', () async {
      final tasks = [taskModel];
      when(() => mockTaskLocalDatasource.getAllTasks()).thenAnswer((_) async => tasks);

      final result = await repository.getAllTasks();

      expect(result, tasks);
      verify(() => mockTaskLocalDatasource.getAllTasks()).called(1);
    });

    test('should update a task', () async {
      when(() => mockTaskLocalDatasource.updateTask(taskEntity.id, taskModel)).thenAnswer((_) async => {});

      await repository.updateTask(taskEntity);

      verify(() => mockTaskLocalDatasource.updateTask(taskEntity.id, taskModel)).called(1);
    });
  });
}
