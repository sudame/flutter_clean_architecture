import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:meta/meta.dart';

abstract class CreateTaskUseCase {
  Future<TaskList> execute({@required String title});
}
