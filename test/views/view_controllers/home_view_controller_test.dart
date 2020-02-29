import 'package:flutter_clean_architecture/domains/usecases/complete_task_usecase.dart';
import 'package:flutter_clean_architecture/domains/usecases/create_task_usecase.dart';
import 'package:flutter_clean_architecture/domains/usecases/list_tasks_usecase.dart';
import 'package:flutter_clean_architecture/entities/task.dart';
import 'package:flutter_clean_architecture/entities/task_list.dart';
import 'package:flutter_clean_architecture/views/view_controllers/home_view_controller.dart';
import 'package:flutter_clean_architecture/views/view_models/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

mixin _CalledCountMixin {
  int calledCount = 0;

  void called() {
    calledCount++;
  }
}

class _MockCreateTaskInteractor
    with _CalledCountMixin
    implements CreateTaskUseCase {
  @override
  Future<TaskList> execute({String title}) async {
    called();
    return const TaskList();
  }
}

class _MockToggleTaskCompletionInteractor
    with _CalledCountMixin
    implements ToggleTaskCompletionUseCase {
  @override
  Future<TaskList> execute(String taskId) async {
    called();
    return const TaskList();
  }
}

class _MockListTasksInteractor
    with _CalledCountMixin
    implements ListTasksUseCase {
  @override
  Future<TaskList> execute() async {
    called();
    return const TaskList();
  }
}

class _MockHomeViewModel extends HomeViewModel with _CalledCountMixin {
  @override
  void updateTasks(List<Task> tasks) {
    called();
  }
}

void main() {
  HomeViewController target;

  group('about HomeViewController, ', () {
    _MockCreateTaskInteractor createTask;
    _MockToggleTaskCompletionInteractor toggleTaskCompletion;
    _MockListTasksInteractor listTasks;
    _MockHomeViewModel viewModel;

    setUp(() {
      createTask = _MockCreateTaskInteractor();
      toggleTaskCompletion = _MockToggleTaskCompletionInteractor();
      listTasks = _MockListTasksInteractor();
      viewModel = _MockHomeViewModel();

      target = HomeViewController(
        createTaskUseCase: createTask,
        toggleTaskCompletionUseCase: toggleTaskCompletion,
        listTasksUseCase: listTasks,
        viewModel: viewModel,
      );
    });

    test('listTasks() should once call ListTaskInteractor', () async {
      // when
      await target.listTasks();

      // then
      expect(listTasks.calledCount, 1);
    });

    test('listTasks() should update ViewModel', () async {
      // when
      await target.listTasks();

      // then
      expect(viewModel.calledCount, 1);
    });

    test('createTask() should once call CreateTaskInteractor', () {
      // when
      target.createTask('title');

      // then
      expect(createTask.calledCount, 1);
    });

    test('createTask() should update ViewModel', () async {
      // when
      await target.createTask('title');

      // then
      expect(viewModel.calledCount, 1);
    });

    test(
        'toggleTaskCompletion() should call once ToggleTaskCompletionInteractor',
        () {
      // when
      target.toggleTaskCompletion('taskId');

      // then
      expect(toggleTaskCompletion.calledCount, 1);
    });

    test('toggleTaskCompletion() should update ViewModel', () async {
      // when
      await target.toggleTaskCompletion('taskId');

      // then
      expect(viewModel.calledCount, 1);
    });
  });
}
