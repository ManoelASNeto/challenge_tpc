import '../../../../core/utils/apps_animation.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/theme_extensions.dart';
import '../cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksDeletedPage extends StatefulWidget {
  const TasksDeletedPage({super.key});

  @override
  State<TasksDeletedPage> createState() => _TasksDeletedPageState();
}

class _TasksDeletedPageState extends State<TasksDeletedPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getAllDeletedTasksBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.tasksDeleteds,
          style: context.titleStyle,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskDeletedLoaded) {
            final deleted = state.tasks;

            if (deleted.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Lottie.asset(AppAnimations.animationTrash),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: deleted.length,
              itemBuilder: (_, index) {
                final task = deleted[index];
                return AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  duration: const Duration(milliseconds: 600),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                    child: Text(
                      task.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }

          if (state is TaskError) {
            return Center(child: Text('Erro: ${state.msgError}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
