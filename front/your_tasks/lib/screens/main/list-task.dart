import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/bloc/login_bloc/login_bloc.dart';
import 'package:your_tasks/bloc/task_bloc/task_bloc.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/screens/main/card.dart';

class ListTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
      if (state is TaskCreated || state is TaskModified) {
        final username = (context.bloc<LoginBloc>().state as Logged).username;
        context.bloc<TaskBloc>().add(FetchTask(username));
      }
    }, builder: (context, state) {
      if (state is FetchingTask) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ErrorFetchingTask) {
        return Center(child: Text('Prueba en otro momento'));
      }

      if (state is FetchTaskLoaded) {
        return LayoutBuilder(builder: (ctx, constraints) {
          return constraints.maxWidth > 660 ? _layoutWeb(state.tasks, context) : _layoutMobile(state.tasks);
        });
      }

      return Container();
    });
  }

  _layoutMobile(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => CardTask(task: tasks[index]),
      padding: EdgeInsets.only(bottom: 50),
    );
  }

  _layoutWeb(List<Task> tasks, context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width / 400).round(), childAspectRatio: 1.5),
      itemCount: tasks.length,
      itemBuilder: (context, index) => CardTask(task: tasks[index]),
      padding: EdgeInsets.only(bottom: 50),
    );
  }
}

/* 
ListWheelScrollView(
              itemExtent: MediaQuery.of(context).size.height / 5,
              diameterRatio: 4,
              //offAxisFraction: -0.5,
              children: snapshot.data); */
