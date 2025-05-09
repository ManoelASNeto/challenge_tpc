import 'package:challenge_tpc/features/task/data/models/task_model.dart';
import 'package:challenge_tpc/features/task/domain/usecases/add_task_to_deleted_box_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/add_task_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_all_tasks_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/deleted_tasks_by_id_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_deleted_box_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/get_all_task_usecase.dart';
import 'package:challenge_tpc/features/task/domain/usecases/update_task_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'features/task/data/datasources/task_local_datasource.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'features/task/domain/repositories/task_repository.dart';
import 'features/task/presentation/cubit/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<TaskLocalDatasource>(
    () => TaskLocalDatasourceImpl(
      tasksBox: sl<Box<TaskModel>>(instanceName: 'tasksBox'),
      deletedTasksBox: sl<Box<TaskModel>>(instanceName: 'deletedTasksBox'),
    ),
  );

  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskLocalDatasource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddTaskUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddTaskToDeletedBoxUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeletedAllTasksUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeletedTasksByIdUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetAllDeletedBoxUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetAllTaskUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateTaskUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => TaskCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}
