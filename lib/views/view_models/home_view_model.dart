import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/entities/task.dart';

class HomeViewModel with ChangeNotifier {
  List<Task> tasks = [];

  void updateTasks(List<Task> tasks) {
    this.tasks = tasks;
    notifyListeners();
  }
}
