part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class FetchTask extends TaskEvent {
  final String username;

  FetchTask(this.username);
}

class DoneTask extends TaskEvent {
  final String id;

  DoneTask(this.id);
}

class CreateTask extends TaskEvent {
  final Task task;

  CreateTask(this.task);
}

class ModifyTask extends TaskEvent {
  final Task newTask;

  ModifyTask(this.newTask);
}
