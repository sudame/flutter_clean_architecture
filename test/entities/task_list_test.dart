import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const task1 = Task(id: 'task1', completed: false, title: 'title1');
  const task2 = Task(id: 'task2', completed: false, title: 'title2');
  const task3 = Task(id: 'task3', completed: true, title: 'title3');
  const task4 = Task(id: 'task4', completed: true, title: 'title4');

  group('about TaskList entity, ', () {
    test('it is created with no tasks by default', () {
      const target = TaskList();

      expect(target.tasks.length, 0);
    });

    test('it is created with passed tasks', () {
      const target = TaskList(tasks: [task1, task2]);

      expect(target.tasks.length, 2);
      expect(target.tasks.contains(task1), true);
      expect(target.tasks.contains(task2), true);
      expect(target.tasks.contains(task3), false);
      expect(target.tasks.contains(task4), false);
    });

    test('append() should append task', () {
      const before = TaskList(tasks: [task1, task2]);

      final updated = before.append(task3);

      expect(updated.tasks.length, 3);
      expect(updated.tasks.contains(task1), true);
      expect(updated.tasks.contains(task2), true);
      expect(updated.tasks.contains(task3), true);
      expect(updated.tasks.contains(task4), false);
    });

    test('remove() should remove task', () {
      const before = TaskList(tasks: [task1, task2]);

      final updated = before.remove(task2.id);

      expect(updated.tasks.length, 1);
      expect(updated.tasks.contains(task1), true);
      expect(updated.tasks.contains(task2), false);
      expect(updated.tasks.contains(task3), false);
      expect(updated.tasks.contains(task4), false);
    });

    test('find() should return the task', () {
      const target = TaskList(tasks: [task1, task2]);

      final foundTask = target.find(task2.id);

      expect(task2 == foundTask, true);
    });

    test('it is compared only by its tasks', () {
      const target1 = TaskList(tasks: [task1, task2]);
      const target2 = TaskList(tasks: [task1, task2]);
      const target3 = TaskList(tasks: [task1, task3]);

      expect(target1 == target2, true);
      expect(target2 == target3, false);
      expect(target3 == target1, false);
    });

    test("its hashCode is same as its tasks' hashCode", () {
      const target1 = TaskList(tasks: [task1, task2]);

      expect(target1.hashCode, target1.tasks.hashCode);
    });
  });
}
