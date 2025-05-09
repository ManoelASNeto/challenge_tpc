import 'package:challenge_tpc/features/task/data/datasources/task_local_datasource.dart';
import 'package:challenge_tpc/features/task/data/models/task_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';

class MockBox<T> extends Mock implements Box<T> {}

void main() {
  late MockBox<TaskModel> mockTasksBox;
  late MockBox<TaskModel> mockDeletedTasksBox;
  late TaskLocalDatasourceImpl datasource;

  setUp(() {
    mockTasksBox = MockBox<TaskModel>();
    mockDeletedTasksBox = MockBox<TaskModel>();
    datasource = TaskLocalDatasourceImpl(
      tasksBox: mockTasksBox,
      deletedTasksBox: mockDeletedTasksBox,
    );
  });

  group('TaskLocalDatasourceImpl', () {
    final task = TaskModel(taskId: '1', taskTitle: 'Test Task', taskIsDone: false);

    test('should add a task to the deleted box and remove it from the tasks box', () async {
      when(() => mockDeletedTasksBox.put(task.taskId, task)).thenAnswer((_) async => {});
      when(() => mockTasksBox.delete(task.taskId)).thenAnswer((_) async => {});

      await datasource.addTaskToDeletedBox(task);

      verify(() => mockDeletedTasksBox.put(task.taskId, task)).called(1);
      verify(() => mockTasksBox.delete(task.taskId)).called(1);
    });

    test('should add a task to the tasks box', () async {
      when(() => mockTasksBox.put(task.taskId, task)).thenAnswer((_) async => {});

      await datasource.addTask(task);

      verify(() => mockTasksBox.put(task.taskId, task)).called(1);
    });

    test('should delete all tasks from the deleted tasks box', () async {
      when(() => mockDeletedTasksBox.clear()).thenAnswer((_) async => 0);

      await datasource.deleteAllTasks();

      verify(() => mockDeletedTasksBox.clear()).called(1);
    });

    test('should delete a task by id from the deleted tasks box', () async {
      const taskId = '1';
      when(() => mockDeletedTasksBox.delete(taskId)).thenAnswer((_) async => {});

      await datasource.deleteTasksById(taskId);

      verify(() => mockDeletedTasksBox.delete(taskId)).called(1);
    });

    test('should return all tasks from the deleted tasks box', () async {
      final tasks = [task];
      when(() => mockDeletedTasksBox.values).thenReturn(tasks);

      final result = await datasource.getAllDeletedBox();

      expect(result, tasks);
      verify(() => mockDeletedTasksBox.values).called(1);
    });

    test('should return all tasks from the tasks box', () async {
      final tasks = [task];
      when(() => mockTasksBox.values).thenReturn(tasks);

      final result = await datasource.getAllTasks();

      expect(result, tasks);
      verify(() => mockTasksBox.values).called(1);
    });

    test('should update a task in the tasks box', () async {
      const taskId = '1';
      when(() => mockTasksBox.put(taskId, task)).thenAnswer((_) async => {});

      await datasource.updateTask(taskId, task);

      verify(() => mockTasksBox.put(taskId, task)).called(1);
    });
  });
}
