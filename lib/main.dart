import 'package:challenge_tpc/features/task/data/models/task_model.dart';
import 'package:challenge_tpc/features/task/presentation/pages/home_page.dart';

import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'features/task/presentation/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(TaskModelAdapter());

  final taskBox = await Hive.openBox<TaskModel>('tasks');
  di.sl.registerSingleton<Box<TaskModel>>(taskBox);

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _router.generateRoutes,
      initialRoute: Routes.homePage,
      home: const HomePage(),
    );
  }
}
