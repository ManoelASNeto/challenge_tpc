import 'package:challenge_tpc/features/task/presentation/pages/home_page.dart';

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
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: taskCubit..allTasks(),
            child: const TaskPage(),
          ),
        );
      case Routes.homePage:
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
