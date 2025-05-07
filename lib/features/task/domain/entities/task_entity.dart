import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TaskEntity({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  TaskEntity copyWith({bool? isDone}) {
    return TaskEntity(
      id: id,
      title: title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isDone,
      ];
}
