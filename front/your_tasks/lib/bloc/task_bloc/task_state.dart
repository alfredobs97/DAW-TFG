part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class FetchingTask extends TaskState {}

class FetchTaskLoaded extends TaskState {
  final List<Task> tasks;

  FetchTaskLoaded(this.tasks);
}

class ErrorFetchingTask extends TaskState {}

class CreatingTask extends TaskState {}

class TaskCreated extends TaskState {}

class ErrorCreatingTask extends TaskState {}

class ModifyingTask extends TaskState {}

class TaskModified extends TaskState {}

class ErrorModifingTask extends TaskState {}
