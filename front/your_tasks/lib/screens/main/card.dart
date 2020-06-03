import 'package:flutter/material.dart';
import 'package:your_tasks/models/task-model.dart';

class CardTask extends StatelessWidget {
  final Task task;
  final Function checkTaskIsDone;
  CardTask({this.task, this.checkTaskIsDone});

  _generateGradient(String priority) {
    Map<String, LinearGradient> gradients = {
      'high': LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.red[700], Colors.redAccent[100]]),
      'medium': LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.orange[700], Colors.orangeAccent[100]]),
      'low': LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.tealAccent[700], Colors.teal[100]])
    };

    return gradients[priority];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onLongPress: () => Navigator.pushNamed(context, '/newTask', arguments: task),
          child: Dismissible(
            background: Container(color: Colors.red),
            key: Key(task.id.toString()),
            onDismissed: (DismissDirection direction  ) {
              this.checkTaskIsDone(task);
            },
            child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Ink(
            decoration: BoxDecoration(
                gradient: _generateGradient(task.priority),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        task.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Text(task.description),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Chip(label: Text(task.from)),
                      Chip(label: Text(task.to))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
