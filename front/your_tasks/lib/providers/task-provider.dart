import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:your_tasks/config/config.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/screens/main/card.dart';
import 'package:your_tasks/providers/token-provider.dart';

class TaskProvider {
  List<Task> tasks = [];
  String endPoint = Config.getEndPoint() + 'tasks/';
  String assignTaskEndPoint = 'assign/';
  String createTaskEndPoint = 'create';
  String isDoneEndPoint = 'finish';
  String token;
  String username;

  Future<dynamic> fetchTask() async {
    // todo think when load token
    this.token = await TokenProvicer.loadToken();
    final response = await http.get(
        this.endPoint + this.assignTaskEndPoint + username,
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode >= 500) {
      throw HttpException('Server error');
    }

    final List<dynamic> listOfTalks = json.decode(response.body);

    this.tasks =
        listOfTalks.map((taskJson) => Task.fromJson(taskJson)).toList();

    this.tasks.sort((taskA, taskB) => taskA.compare(taskB) ? 1 : 0);

    return this
        .tasks
        .map((task) => CardTask(task: task, checkTaskIsDone: this.isDone))
        .toList();
  }

  isDone(Task task) {
    http.post(this.endPoint + this.isDoneEndPoint,
        body: {'id': task.id.toString(), 'isDone': 'true'},
        headers: {'Authorization': 'Bearer $token'});
  }

  createTask(Map<String, String> taskRaw) async {
    this.token = await TokenProvicer.loadToken();
    print(this.token);
    final response = await http.post(this.endPoint + this.createTaskEndPoint,
        body: taskRaw, headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);
  }

  modifyTask(Map<String, String> taskRaw) async {
    this.token = await TokenProvicer.loadToken();

    final response = await http.put(this.endPoint,
        body: taskRaw, headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);
  }
}
