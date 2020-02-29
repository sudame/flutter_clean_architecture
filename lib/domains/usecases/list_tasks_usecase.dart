import 'package:flutter_clean_architecture/entities/task_list.dart';

abstract class ListTasksUseCase {
  Future<TaskList> execute();
}
