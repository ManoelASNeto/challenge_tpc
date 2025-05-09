import 'package:challenge_tpc/features/task/data/models/task_model.dart';
import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskModel', () {
    const taskModel = TaskModel(
      taskId: '1',
      taskTitle: 'Test Task',
      taskIsDone: false,
    );

    test('should be a subclass of TaskEntity', () {
      expect(taskModel, isA<TaskEntity>());
    });

    test('should correctly convert from TaskEntity', () {
      const taskEntity = TaskEntity(
        id: '1',
        title: 'Test Task',
        isDone: false,
      );

      final result = TaskModel.fromEntity(taskEntity);

      expect(result.taskId, taskEntity.id);
      expect(result.taskTitle, taskEntity.title);
      expect(result.taskIsDone, taskEntity.isDone);
    });
  });
}
