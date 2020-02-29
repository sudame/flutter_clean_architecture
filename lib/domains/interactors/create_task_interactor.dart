import 'package:flutter_clean_architecture/data/repository_bases/task_repository.dart';
import 'package:flutter_clean_architecture/domains/usecases/create_task_usecase.dart';
import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:meta/meta.dart';

class CreateTaskInteractor implements CreateTaskUseCase {
  CreateTaskInteractor({
    @required TaskRepository taskRepo,
  }) : _taskRepo = taskRepo;

  final TaskRepository _taskRepo;

  @override
  Future<TaskList> execute({@required String title}) async {
    final task = Task(
      title: title,
      completed: false,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await _taskRepo.add(task);
    return TaskList(tasks: await _taskRepo.findAll());
  }
}
