// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoaded({
    required this.tasks,
  });
  @override
  List<Object> get props => [tasks];
}

class TaskDeletedLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TaskDeletedLoaded({
    required this.tasks,
  });
  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String? msgError;

  const TaskError({required this.msgError});
}
