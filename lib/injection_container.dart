import 'features/task/data/datasources/task_local_datasource.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'features/task/domain/repositories/task_repository.dart';
import 'features/task/domain/usecases/task_usecase.dart';
import 'features/task/presentation/cubit/task_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<TaskLocalDatasource>(
    () => TaskLocalDatasourceImpl(
      box: sl(),
    ),
  );

  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskLocalDatasource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => TaskUsecase(
      taskRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => TaskCubit(
      sl(),
    ),
  );
}
