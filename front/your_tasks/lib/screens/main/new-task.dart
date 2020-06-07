import 'package:flutter/material.dart';
import 'package:your_tasks/bloc/task_bloc/task_bloc.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/widgets/components/from_task.dart';
import 'package:your_tasks/widgets/snackbars.dart';

class NewTask extends StatefulWidget {
  final Task taskEditing;

  const NewTask({Key key, this.taskEditing}) : super(key: key);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
        listener: (context, state) async {
          if (state is ErrorCreatingTask) _scaffoldKey.currentState.showSnackBar(SnackBars.errorTask);
          if (state is TaskCreated) _scaffoldKey.currentState.showSnackBar(SnackBars.taskSend);
          if (state is TaskModified) {
            _scaffoldKey.currentState.showSnackBar(SnackBars.modifiedTask);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: widget.taskEditing != null
              ? AppBar(
                  title: Text('Edita tu tarea'),
                )
              : null,
          body: Padding(padding: const EdgeInsets.all(16.0), child: FormTask(taskEditing: widget.taskEditing)),
        ));
  }
}
