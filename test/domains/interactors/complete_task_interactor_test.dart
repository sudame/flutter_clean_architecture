import 'package:flutter_clean_architecture/data/repositories/task_repository.dart';
import 'package:flutter_clean_architecture/data/repository_bases/task_repository.dart';
import 'package:flutter_clean_architecture/domains/interactors/complete_task_interactor.dart';
import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('about CompleteTaskInteractor, ', () {
    TaskRepository taskRepo;
    ToggleTaskCompletionInteractor target;

    setUp(() async {
      taskRepo = OnMemoryTaskRepository();

      // remove all tasks
      for (final task in await taskRepo.findAll()) {
        taskRepo.remove(task.id);
      }

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

      target = ToggleTaskCompletionInteractor(taskRepo: taskRepo);
    });

    test('it should make the task completed', () async {
      // given
      final targetTask = await taskRepo.find('id_3');

      // when
      await target.execute(targetTask.id);

      // then
      expect((await taskRepo.find(targetTask.id)).completed, true);
    });

    test('it should not change the number of tasks', () async {
      // given
      final targetTask = await taskRepo.find('id_3');

      // when
      await target.execute(targetTask.id);

      // then
      expect((await taskRepo.findAll()).length, 10);
    });

    test('it should response all tasks', () async {
      // given
      final targetTask = await taskRepo.find('id_3');

      // when
      final response = await target.execute(targetTask.id);

      // then
      expect(response.tasks.length, 10);
    });
  });
}
