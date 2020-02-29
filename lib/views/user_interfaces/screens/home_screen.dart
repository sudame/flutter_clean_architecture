import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/repositories/task_repository.dart';
import 'package:flutter_clean_architecture/domains/interactors/complete_task_interactor.dart';
import 'package:flutter_clean_architecture/domains/interactors/create_task_interactor.dart';
import 'package:flutter_clean_architecture/domains/interactors/list_tasks_interactor.dart';
import 'package:flutter_clean_architecture/views/view_controllers/home_view_controller.dart';
import 'package:flutter_clean_architecture/views/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel();
    final taskRepo = OnMemoryTaskRepository();
    final createTask = CreateTaskInteractor(taskRepo: taskRepo);
    final listTasks = ListTasksInteractor(taskRepo: taskRepo);
    final toggleTaskCompletion =
        ToggleTaskCompletionInteractor(taskRepo: taskRepo);
    final controller = HomeViewController(
      viewModel: viewModel,
      createTaskUseCase: createTask,
      listTasksUseCase: listTasks,
      toggleTaskCompletionUseCase: toggleTaskCompletion,
    );

    controller.listTasks();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>.value(value: viewModel),
        Provider<HomeViewController>.value(value: controller),
      ],
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  void _showTaskEditDialog(BuildContext context) {
    final viewController =
        Provider.of<HomeViewController>(context, listen: false);
    final titleController = TextEditingController();

    showDialog<AlertDialog>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'title',
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Add'),
            onPressed: () async {
              await viewController.createTask(titleController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeViewController>(context, listen: false);

    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.tasks.length,
            itemBuilder: (context, index) => ListTile(
              leading: Checkbox(
                value: value.tasks[index].completed,
                onChanged: (completed) {
                  controller.toggleTaskCompletion(value.tasks[index].id);
                },
              ),
              title: Text(value.tasks[index].title),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showTaskEditDialog(context);
        },
      ),
    );
  }
}
