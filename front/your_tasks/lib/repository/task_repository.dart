import 'dart:convert';
import 'dart:io';

import 'package:your_tasks/config/config.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/providers/token-provider.dart';

import 'package:http/http.dart' as http;

class TaskRepository {
  String endPoint = Config.getEndPoint() + 'tasks/';
  String assignTaskEndPoint = 'assign/';
  String createTaskEndPoint = 'create';
  String isDoneEndPoint = 'finish';
  String token;

  TaskRepository() {
    TokenProvider.loadToken().then((token) => this.token = token);
  }

  Future<List<Task>> fetchTask(String username) async {
    final response =
        await http.get(this.endPoint + this.assignTaskEndPoint + username, headers: {'Authorization': 'Bearer ${this.token}'});

    if (response.statusCode >= 500) {
      throw HttpException('Server error');
    }

    final List<dynamic> listOfTalks = json.decode(response.body);

    final tasks = listOfTalks.map((taskJson) => Task.fromJson(taskJson)).toList();

    tasks.sort((taskA, taskB) => taskA.compare(taskB) ? 1 : 0);

    return tasks;
  }

  void isDone(String id) {
    http.post(this.endPoint + this.isDoneEndPoint,
        body: {'id': id, 'isDone': 'true'}, headers: {'Authorization': 'Bearer $token'});
  }

  Future<bool> createTask(Task task) async {
    final response = await http
        .post(this.endPoint + this.createTaskEndPoint, body: task.toMap(), headers: {'Authorization': 'Bearer $token'});

    return response.statusCode == 200;
  }

  Future<bool> modifyTask(Task task) async {
    print(task.toString());
    final response = await http.put(this.endPoint, body: task.toMap(), headers: {'Authorization': 'Bearer $token'});

    print('Respuesta modify ${response.statusCode}');
    return response.statusCode == 200;
  }
}
