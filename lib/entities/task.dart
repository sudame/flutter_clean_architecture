import 'package:meta/meta.dart';

@immutable
class Task {
  const Task({
    @required this.id,
    @required this.title,
    @required this.completed,
  });

  final String id;
  final String title;
  final bool completed;

  Task update({String title, bool completed}) {
    return Task(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
