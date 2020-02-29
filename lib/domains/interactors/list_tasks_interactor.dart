import 'package:flutter_clean_architecture/data/repository_bases/task_repository.dart';
import 'package:flutter_clean_architecture/domains/usecases/list_tasks_usecase.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:meta/meta.dart';

class ListTasksInteractor implements ListTasksUseCase {
  ListTasksInteractor({
    @required TaskRepository taskRepo,
  }) : _taskRepo = taskRepo;

  final TaskRepository _taskRepo;

  @override
  Future<TaskList> execute() async {
    return TaskList(tasks: await _taskRepo.findAll());
  }
}
