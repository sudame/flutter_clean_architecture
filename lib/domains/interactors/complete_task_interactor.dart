import 'package:flutter_clean_architecture/data/repository_bases/task_repository.dart';
import 'package:flutter_clean_architecture/domains/usecases/complete_task_usecase.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';

class ToggleTaskCompletionInteractor implements ToggleTaskCompletionUseCase {
  ToggleTaskCompletionInteractor({TaskRepository taskRepo}) : _taskRepo = taskRepo;

  final TaskRepository _taskRepo;

  @override
  Future<TaskList> execute(String taskId) async {
    final targetTask = await _taskRepo.find(taskId);
    final updatedTask = targetTask.update(completed: !targetTask.completed);
    await _taskRepo.update(updatedTask);
    return TaskList(tasks: await _taskRepo.findAll());
  }
}
