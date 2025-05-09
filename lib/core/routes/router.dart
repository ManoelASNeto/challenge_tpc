import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/task/presentation/cubit/task_cubit.dart';
import '../../features/task/presentation/pages/task_page.dart';
import '../../features/task/presentation/pages/tasks_deleted_page.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final taskCubit = sl<TaskCubit>();

    switch (settings.name) {
      case Routes.taskPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: taskCubit..getAllTasks(),
              child: TaskPage(),
            );
          },
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return child;
          },
        );
      case Routes.deletedTaskPage:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) {
              return BlocProvider.value(
                value: taskCubit..getAllDeletedBox(),
                child: const TasksDeletedPage(),
              );
            });
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Sem dados'),
            ),
          ),
        );
    }
  }
}
