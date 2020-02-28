import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:meta/meta.dart';

@immutable
class TaskList {
  const TaskList({this.tasks = const []});

  final List<Task> tasks;

  TaskList append(Task task) {
    final updatedTasks = List<Task>.from(tasks)..add(task);
    return TaskList(tasks: updatedTasks);
  }

  TaskList remove(String id) {
    final target = tasks.firstWhere((task) => task.id == id);
    final updatedTasks = List<Task>.from(tasks)..remove(target);
    return TaskList(tasks: updatedTasks);
  }

  Task find(String id) {
    return tasks.firstWhere((task) => task.id == id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskList &&
          runtimeType == other.runtimeType &&
          tasks == other.tasks;

  @override
  int get hashCode => tasks.hashCode;
}
