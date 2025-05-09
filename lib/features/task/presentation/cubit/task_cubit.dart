import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/add_task_to_deleted_box_usecase.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/deleted_all_tasks_usecase.dart';
import '../../domain/usecases/deleted_tasks_by_id_usecase.dart';
import '../../domain/usecases/get_all_deleted_box_usecase.dart';
import '../../domain/usecases/get_all_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTaskUsecase addTaskUsecase;
  final AddTaskToDeletedBoxUsecase addTaskToDeletedBoxUsecase;
  final DeletedAllTasksUsecase deletedAllTasks;
  final DeletedTasksByIdUsecase deletedTasksById;
  final GetAllDeletedBoxUsecase getAllDeletedBox;
  final GetAllTaskUsecase getAllTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;

  TaskCubit(
    this.addTaskToDeletedBoxUsecase,
    this.addTaskUsecase,
    this.deletedAllTasks,
    this.deletedTasksById,
    this.getAllDeletedBox,
    this.getAllTaskUsecase,
    this.updateTaskUsecase,
  ) : super(TaskInitial());

  List<TaskEntity> _activeTasks = [];
  List<TaskEntity> _deletedTasks = [];

  List<TaskEntity> get activeTasks => _activeTasks;
  List<TaskEntity> get deletedTasks => _deletedTasks;

  Future<void> loadAll() async {
    await getAllTasks();
    await getAllDeletedTasksBox();
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await addTaskUsecase.call(task);
      await getAllTasks();
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorAdd} ${e.toString()}'));
    }
  }

  Future<void> deleteTaskById(TaskEntity task) async {
    try {
      await addTaskToDeletedBoxUsecase.call(task);
      _deletedTasks = await getAllDeletedBox.call();
      await getAllTasks();
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorDelete} ${e.toString()}'));
    }
  }

  Future<void> deleteAllTasks() async {
    try {
      await deletedAllTasks.call();
      await getAllDeletedTasksBox();
      emit(TaskDeletedLoaded(tasks: deletedTasks));
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorDelete} ${e.toString()}'));
    }
  }

  Future<void> getAllTasks() async {
    try {
      final tasks = await getAllTaskUsecase.call();
      _activeTasks = tasks;
      emit(TaskLoaded(tasks: _activeTasks));
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorLoading} ${e.toString()}'));
    }
  }

  Future<void> getAllDeletedTasksBox() async {
    try {
      final tasks = await getAllDeletedBox.call();
      _deletedTasks = tasks;
      emit(TaskDeletedLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorLoading} ${e.toString()}'));
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      final updated = task.copyWith(isDone: !task.isDone);
      await updateTaskUsecase.call(updated);
      await getAllTasks();
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorUpdate} ${e.toString()}'));
    }
  }
}
