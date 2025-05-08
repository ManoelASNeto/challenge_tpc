import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/apps_animation.dart';
import '../../../../core/utils/theme_extensions.dart';
import '../cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskLoaded) {
          final tasks = state.tasks;

          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Lottie.asset(AppAnimations.animationTodo),
                  ),
                  Text(
                    AppStrings.addNewTask,
                    style: context.titleStyle,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final task = tasks[index];
              return AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                duration: const Duration(
                  milliseconds: 600,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Dismissible(
                  key: ValueKey(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) async {
                    context.read<TaskCubit>().deleteTaskById(task);
                  },
                  child: CheckboxListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    value: task.isDone,
                    onChanged: (_) {
                      context.read<TaskCubit>().updateTask(task);
                    },
                  ),
                ),
              );
            },
          );
        }
        if (state is TaskError) {
          return Center(child: Text('Erro: ${state.msgError ?? ''}'));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
