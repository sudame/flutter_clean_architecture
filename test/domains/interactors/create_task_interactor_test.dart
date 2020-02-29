import 'package:flutter_clean_architecture/data/repositories/task_repository.dart';
import 'package:flutter_clean_architecture/domains/interactors/create_task_interactor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final taskRepo = OnMemoryTaskRepository();
  CreateTaskInteractor target;

  setUp(() {
    target = CreateTaskInteractor(
      taskRepo: taskRepo,
    );
  });

  group('about CreateTaskInteractor, ', () {
    test('it should add a task', () async {
      // given
      final allTaskBefore = await taskRepo.findAll();

      // when
      await target.execute(title: 'task_title');

      // then
      final allTaskAfter = await taskRepo.findAll();
      expect(allTaskBefore.length + 1, allTaskAfter.length);
    });

    test('its response contains all tasks', () async {
      // when
      final response = await target.execute(title: 'task_title');

      // then
      final allTaskAfter = await taskRepo.findAll();
      expect(response.tasks, allTaskAfter);
    });
  });
}
