import 'package:challenge_tpc/core/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.taskPage);
              },
              child: Text('Tarefas')),
        ),
      ),
    );
  }
}
