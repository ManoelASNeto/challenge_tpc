import 'routes.dart';
import '../../features/task/presentation/cubit/task_cubit.dart';
import '../../features/task/presentation/pages/task_page.dart';
import '../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final taskCubit = sl<TaskCubit>();

    switch (settings.name) {
      case Routes.taskPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: taskCubit..allTasks(),
              child: const TaskPage(),
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
