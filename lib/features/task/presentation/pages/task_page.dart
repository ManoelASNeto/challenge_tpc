import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/theme_extensions.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/task_cubit.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'task_list_page.dart';
import 'tasks_deleted_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int _activeIndex = 0;

  void _onTap(int index) {
    setState(() {
      _activeIndex = index;
    });
    if (_activeIndex == 0) {
      context.read<TaskCubit>().getAllTasks();
    }
  }

  final List<Widget> _pages = [
    const TaskListPage(),
    const TasksDeletedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.title,
          style: context.titleStyle,
        ),
        centerTitle: true,
      ),
      body: _pages[_activeIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _activeIndex == 0
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: AppColors.primaryColor,
              onPressed: () => _showAddTaskDialog(context),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.red,
              onPressed: () => _showDeleteConfirmationDialog(context),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
      bottomNavigationBar: CustomBottomNavbar(
        activeIndex: _activeIndex,
        onTap: _onTap,
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          AppStrings.newTask,
          style: context.titleStyle,
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: AppStrings.inputNewTask),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final title = controller.text.trim();
              if (title.isNotEmpty) {
                final newTask = TaskEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  isDone: false,
                );
                context.read<TaskCubit>().addTask(newTask);
              }
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.add),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir todas as tarefas?'),
        content: const Text('Essa ação removerá permanentemente todas as tarefas excluídas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskCubit>().deleteAllTasks();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir tudo'),
          ),
        ],
      ),
    );
  }
}
