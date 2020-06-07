import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/bloc/login_bloc/login_bloc.dart';
import 'package:your_tasks/bloc/task_bloc/task_bloc.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/screens/main/card.dart';

class ListTask extends StatelessWidget {
  Future<void> _refreshList(BuildContext context) async {
    final username = (context.bloc<LoginBloc>().state as Logged).username;
    context.bloc<TaskBloc>().add(FetchTask(username));
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(listener: (_, state) {
      if (state is TaskCreated || state is TaskModified || state is TaskIsDone) {
        _refreshList(context);
      }
    }, builder: (_, state) {
      if (state is FetchingTask) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ErrorFetchingTask) {
        return Center(child: Text('Prueba en otro momento'));
      }

      if (state is FetchTaskLoaded) {
        return LayoutBuilder(builder: (_, constraints) {
          return constraints.maxWidth > 660 ? _layoutWeb(state.tasks, context) : _layoutMobile(state.tasks, context);
        });
      }

      return Container();
    });
  }

  _layoutMobile(List<Task> tasks, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return _refreshList(context);
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) => CardTask(task: tasks[index]),
        padding: EdgeInsets.only(bottom: 50),
      ),
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
