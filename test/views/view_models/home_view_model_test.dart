import 'dart:async';

import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_clean_architecture/views/view_models/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('about HomeViewModel, ', () {
    HomeViewModel target;
    const tasks = [
      Task(id: 'id_1', completed: false, title: 'title_1'),
      Task(id: 'id_2', completed: true, title: 'title_2'),
      Task(id: 'id_3', completed: false, title: 'title_3'),
    ];

    setUp(() {
      target = HomeViewModel();
    });

    test('', () async {
      // given
      final _controller = StreamController<String>();
      target.addListener(() {
        _controller.add('updated!');
      });

      // when
      target.updateTasks(tasks);

      // then
      await expectLater(_controller.stream, emits('updated!'));

      // after care
      _controller.close();
    });
  });
}
