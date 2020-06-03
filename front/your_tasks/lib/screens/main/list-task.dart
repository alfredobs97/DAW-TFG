import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks/providers/login-provider.dart';
import 'package:your_tasks/providers/task-provider.dart';

class ListTask extends StatefulWidget {
  @override
  _ListTaskState createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  // todo order by priority
  final taskProvider = TaskProvider();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    taskProvider.username = loginProvider.username;

    return FutureBuilder(
        future: taskProvider.fetchTask(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Prueba en otro momento'));
          }

          return LayoutBuilder(builder: (ctx, constraints) {
            return constraints.maxWidth > 660
                ? _layoutWeb(snapshot)
                : _layoutMobile(snapshot);
          });
        });
  }

  _layoutMobile(snapshot) {
    return ListView(
      children: snapshot.data,
      padding: EdgeInsets.only(bottom: 50),
    );
  }

  _layoutWeb(snapshot) {
    return GridView.count(
      crossAxisCount: (MediaQuery.of(context).size.width / 400).round(),
      childAspectRatio: 1.5,
      children: snapshot.data,
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
