import 'package:challenge_tpc/core/utils/app_colors.dart';
import 'package:challenge_tpc/core/utils/app_strings.dart';
import 'package:challenge_tpc/core/utils/theme_extensions.dart';
import 'package:challenge_tpc/features/task/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../cubit/task_cubit.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.myTasks,
          style: context.titleStyle,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            final tasks = state.tasks;

            if (tasks.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset(AppStrings.animationTodo),
                    Text(
                      'Adicione uma nova Tarefa!',
                      style: context.subtitleTextStyle,
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
                    onDismissed: (_) {
                      context.read<TaskCubit>().deleteTask(task.id);
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
                        context.read<TaskCubit>().toggleTask(task);
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

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Nova Tarefa',
          style: context.titleStyle,
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Digite o título da tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
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
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
