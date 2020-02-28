import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('about Task entity, ', () {
    test('it can be created with proper fields', () {
      const target = Task(completed: false, title: 'title', id: 'id');

      expect(target.completed, false);
      expect(target.title, 'title');
      expect(target.id, 'id');
    });

    test('it can be updated', () {
      const before = Task(completed: false, title: 'title', id: 'id');
      final updated1 = before.update(completed: true);
      final updated2 = before.update(title: 'updated_title');

      expect(updated1.completed, true);
      expect(updated1.title, 'title');
      expect(updated1.id, 'id');

      expect(updated2.completed, false);
      expect(updated2.title, 'updated_title');
      expect(updated2.id, 'id');
    });

    test('it should be compared only by id', () {
      const target1 = Task(completed: false, id: 'id', title: 'title1');
      const target2 = Task(completed: true, id: 'id', title: 'title2');
      const target3 = Task(completed: false, id: 'other_id', title: 'title1');

      expect(target1 == target2, true);
      expect(target1 == target3, false);
      expect(target2 == target3, false);
    });

    test("its own hashCode is equal with its id's hashCode", () {
      const target = Task(completed: false, id: 'id', title: 'title1');

      expect(target.hashCode, 'id'.hashCode);
    });
  });
}
