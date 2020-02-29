import 'package:flutter_clean_architecture/data/repositories/task_repository.dart';
import 'package:flutter_clean_architecture/domains/interactors/list_tasks_interactor.dart';
import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final taskRepo = OnMemoryTaskRepository();
  ListTasksInteractor target;

  setUp(() {
    // save 10 tasks to repository
    for (var i = 0; i < 10; i++) {
      taskRepo.add(
        Task(
          id: 'id_' + i.toString(),
          completed: false,
          title: 'title_' + i.toString(),
        ),
      );
    }

    target = ListTasksInteractor(taskRepo: taskRepo);
  });

  group('about ListTasksInteractor, ', () {
    test('it should list all tasks', () async {
      // when
      final response = await target.execute();

      // then
      expect(response.tasks.length, 10);
    });
  });
}
