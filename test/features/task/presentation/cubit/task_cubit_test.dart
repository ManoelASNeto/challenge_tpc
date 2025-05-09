import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:challenge_tpc/features/task/domain/usecases/add_task_to_deleted_box_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/add_task_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_all_tasks_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_tasks_by_id_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_deleted_box_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_task_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/update_task_usecase.dart';
import 'package:challenge_tpc/features/task/presentation/cubit/task_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddTaskUsecase extends Mock implements AddTaskUsecase {}

class MockAddTaskToDeletedBoxUsecase extends Mock implements AddTaskToDeletedBoxUsecase {}

class MockDeletedAllTasksUsecase extends Mock implements DeletedAllTasksUsecase {}

class MockDeletedTasksByIdUsecase extends Mock implements DeletedTasksByIdUsecase {}

class MockGetAllDeletedBoxUsecase extends Mock implements GetAllDeletedBoxUsecase {}

class MockGetAllTaskUsecase extends Mock implements GetAllTaskUsecase {}

class MockUpdateTaskUsecase extends Mock implements UpdateTaskUsecase {}

void main() {
  late TaskCubit taskCubit;
  late MockAddTaskUsecase mockAddTaskUsecase;
  late MockAddTaskToDeletedBoxUsecase mockAddTaskToDeletedBoxUsecase;
  late MockDeletedAllTasksUsecase mockDeletedAllTasksUsecase;
  late MockDeletedTasksByIdUsecase mockDeletedTasksByIdUsecase;
  late MockGetAllDeletedBoxUsecase mockGetAllDeletedBoxUsecase;
  late MockGetAllTaskUsecase mockGetAllTaskUsecase;
  late MockUpdateTaskUsecase mockUpdateTaskUsecase;

  setUp(() {
    mockAddTaskUsecase = MockAddTaskUsecase();
    mockAddTaskToDeletedBoxUsecase = MockAddTaskToDeletedBoxUsecase();
    mockDeletedAllTasksUsecase = MockDeletedAllTasksUsecase();
    mockDeletedTasksByIdUsecase = MockDeletedTasksByIdUsecase();
    mockGetAllDeletedBoxUsecase = MockGetAllDeletedBoxUsecase();
    mockGetAllTaskUsecase = MockGetAllTaskUsecase();
    mockUpdateTaskUsecase = MockUpdateTaskUsecase();

    taskCubit = TaskCubit(
      mockAddTaskToDeletedBoxUsecase,
      mockAddTaskUsecase,
      mockDeletedAllTasksUsecase,
      mockDeletedTasksByIdUsecase,
      mockGetAllDeletedBoxUsecase,
      mockGetAllTaskUsecase,
      mockUpdateTaskUsecase,
    );
  });

  const task = TaskEntity(id: '1', title: 'Test Task', isDone: false);

  group('TaskCubit', () {
    blocTest<TaskCubit, TaskState>(
      'emits [TaskLoaded] when loadAll is called',
      build: () {
        when(() => mockGetAllTaskUsecase.call()).thenAnswer((_) async => [task]);
        when(() => mockGetAllDeletedBoxUsecase.call()).thenAnswer((_) async => [task]);
        return taskCubit;
      },
      act: (cubit) => cubit.loadAll(),
      expect: () => [
        TaskLoaded(tasks: [task]),
        TaskDeletedLoaded(tasks: [task]),
      ],
      verify: (_) {
        verify(() => mockGetAllTaskUsecase.call()).called(1);
        verify(() => mockGetAllDeletedBoxUsecase.call()).called(1);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'calls addTaskUsecase and emits [TaskLoaded] when addTask is called',
      build: () {
        when(() => mockAddTaskUsecase.call(task)).thenAnswer((_) async => {});
        when(() => mockGetAllTaskUsecase.call()).thenAnswer((_) async => [task]);
        return taskCubit;
      },
      act: (cubit) => cubit.addTask(task),
      expect: () => [
        TaskLoaded(tasks: [task]),
      ],
      verify: (_) {
        verify(() => mockAddTaskUsecase.call(task)).called(1);
        verify(() => mockGetAllTaskUsecase.call()).called(1);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'calls addTaskToDeletedBoxUsecase and emits [TaskDeletedLoaded] when deleteTaskById is called',
      build: () {
        when(() => mockAddTaskToDeletedBoxUsecase.call(task)).thenAnswer((_) async => {});
        when(() => mockGetAllDeletedBoxUsecase.call()).thenAnswer((_) async => [task]);
        when(() => mockGetAllTaskUsecase.call()).thenAnswer((_) async => []);
        return taskCubit;
      },
      act: (cubit) => cubit.deleteTaskById(task),
      expect: () => [
        TaskLoaded(tasks: []),
      ],
      verify: (_) {
        verify(() => mockAddTaskToDeletedBoxUsecase.call(task)).called(1);
        verify(() => mockGetAllDeletedBoxUsecase.call()).called(1);
        verify(() => mockGetAllTaskUsecase.call()).called(1);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'calls updateTaskUsecase and emits [TaskLoaded] when updateTask is called',
      build: () {
        final updatedTask = task.copyWith(isDone: true);
        when(() => mockUpdateTaskUsecase.call(updatedTask)).thenAnswer((_) async => {});
        when(() => mockGetAllTaskUsecase.call()).thenAnswer((_) async => [updatedTask]);
        return taskCubit;
      },
      act: (cubit) => cubit.updateTask(task),
      expect: () => [
        TaskLoaded(tasks: [task.copyWith(isDone: true)]),
      ],
      verify: (_) {
        verify(() => mockUpdateTaskUsecase.call(task.copyWith(isDone: true))).called(1);
        verify(() => mockGetAllTaskUsecase.call()).called(1);
      },
    );
  });
}
