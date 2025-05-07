import 'package:bloc/bloc.dart';
import 'package:challenge_tpc/core/utils/app_strings.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskUsecase taskUsecase;

  TaskCubit(
    this.taskUsecase,
  ) : super(TaskInitial());

  Future<void> allTasks() async {
    try {
      emit(TaskLoading());
      final tasks = await taskUsecase.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorLoading} ${e.toString()}'));
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await taskUsecase.add(task);
      await allTasks();
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorAdd} ${e.toString()}'));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await taskUsecase.deleteTask(id);
      await allTasks();
    } catch (e) {
      emit(TaskError(msgError: '${AppStrings.taskErrorDelete} ${e.toString()}'));
    }
  }
}
