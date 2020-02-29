import 'package:flutter_clean_architecture/entities/task_list.dart';

abstract class ToggleTaskCompletionUseCase {
  Future<TaskList> execute(String taskId);
}
