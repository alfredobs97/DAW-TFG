import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _taskRepository = TaskRepository();
  
  @override
  TaskState get initialState => TaskInitial();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if(event is FetchTask) yield* _mapFetchTaskState(event.username);
    if(event is DoneTask) yield* _mapDoneTaskState(event.id);
    if(event is CreateTask) yield* _mapCreateTaskState(event.task);
    if(event is ModifyTask) yield* _mapModifyTaskState(event.newTask);
  }

  Stream<TaskState> _mapFetchTaskState(String username) async* {
    yield FetchingTask();
    try {
      final task = await _taskRepository.fetchTask(username);
      yield FetchTaskLoaded(task);
    } catch (e) {
      yield ErrorFetchingTask();
    }
  }

  Stream<TaskState> _mapDoneTaskState(String id) async* {
    _taskRepository.isDone(id);
  }

  Stream<TaskState> _mapCreateTaskState(Task task) async* {
    yield CreatingTask();
    try {
      await _taskRepository.createTask(task);
      yield TaskCreated();
    } catch (e) {
      yield ErrorCreatingTask();
    }
  }

  Stream<TaskState> _mapModifyTaskState(Task task) async* {
    yield ModifyingTask();
    try {
      await _taskRepository.modifyTask(task);
      yield TaskModified();
    } catch (e) {
      yield ErrorModifingTask();
    }
  }




}
