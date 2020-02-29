import 'package:flutter_clean_architecture/entities/task.dart';

abstract class TaskRepository {
  Future<void> add(Task task);

  Future<void> remove(String taskId);

  Future<void> update(Task task);

  Future<List<Task>> findAll();

  Future<Task> find(String taskId);
}
