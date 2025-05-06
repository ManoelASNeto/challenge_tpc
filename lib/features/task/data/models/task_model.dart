import 'package:hive/hive.dart';

import '../../domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends TaskEntity {
  @HiveField(0)
  final String taskId;

  @HiveField(1)
  final String taskTitle;

  @HiveField(2)
  final bool taskIsDone;

  const TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskIsDone,
  }) : super(id: taskId, title: taskTitle, isDone: taskIsDone);

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      taskId: task.id,
      taskTitle: task.title,
      taskIsDone: task.isDone,
    );
  }
}
