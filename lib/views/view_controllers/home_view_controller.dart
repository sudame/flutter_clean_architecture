import 'package:flutter_clean_architecture/domains/usecases/complete_task_usecase.dart';
import 'package:flutter_clean_architecture/domains/usecases/create_task_usecase.dart';
import 'package:flutter_clean_architecture/domains/usecases/list_tasks_usecase.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:flutter_clean_architecture/views/view_models/home_view_model.dart';
import 'package:meta/meta.dart';

class HomeViewController {
  HomeViewController({
    @required ListTasksUseCase listTasksUseCase,
    @required HomeViewModel viewModel,
    @required CreateTaskUseCase createTaskUseCase,
    @required ToggleTaskCompletionUseCase toggleTaskCompletionUseCase,
  })  : _listTasks = listTasksUseCase,
        _viewModel = viewModel,
        _createTask = createTaskUseCase,
        _completeTask = toggleTaskCompletionUseCase;

  final HomeViewModel _viewModel;
  final ListTasksUseCase _listTasks;
  final CreateTaskUseCase _createTask;
  final ToggleTaskCompletionUseCase _completeTask;

  Future<void> listTasks() async {
    final taskList = await _listTasks.execute();
    _updateTaskList(taskList);
  }

  Future<void> createTask(String title) async {
    final taskList = await _createTask.execute(title: title);
    _updateTaskList(taskList);
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final taskList = await _completeTask.execute(taskId);
    _updateTaskList(taskList);
  }

  void _updateTaskList(TaskList taskList) {
    _viewModel.updateTasks(taskList.tasks);
  }
}
