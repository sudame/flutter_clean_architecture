import 'package:flutter_clean_architecture/data/repository_bases/task_repository.dart';
import 'package:flutter_clean_architecture/entities/task.dart';

class OnMemoryTaskRepository implements TaskRepository {
  factory OnMemoryTaskRepository() =>
      _instance ??= OnMemoryTaskRepository._init();

  OnMemoryTaskRepository._init();

  static OnMemoryTaskRepository _instance;

  final List<Task> _tasks = <Task>[];

  @override
  Future<void> add(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<Task> find(String taskId) async {
    return _tasks.firstWhere((task) => task.id == taskId);
  }

  @override
  Future<List<Task>> findAll() async {
    return List<Task>.from(_tasks);
  }

  @override
  Future<void> remove(String taskId) async {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    if (task != null) {
      _tasks.remove(task);
    }
  }

  @override
  Future<void> update(Task task) async {
    final targetTask = _tasks.firstWhere((t) => t.id == task.id);
    final index = _tasks.indexOf(targetTask);
    if (targetTask != null) {
      _tasks.removeAt(index);
      _tasks.insert(index, task);
    }
  }
}
