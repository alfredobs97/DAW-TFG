import 'dart:convert';

class Task {
  int id;
  String name;
  // TODO think enum or String
  String priority;
  String to;
  String from;
  String description;
  bool isDone;

  Task({
    this.id,
    this.name,
    this.priority,
    this.to,
    this.from,
    this.description,
    this.isDone,
  });

  Task.fromJson(Map<dynamic, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.priority = json['priority'];
    this.to = json['to'] != null ? json['to']['username'] : '';
    this.from = json['from'] != null ? json['from']['username'] : '';
    this.description = json['description'];
    this.isDone = json['isDone'];
  }

  bool compare(Task task){
    Map<String, bool> comparations = {
      'high' : this.priority != 'high' ?? false,
      'medium' : this.priority == 'high' || this.priority == 'medium' ? false : true,
      'low' : false
    };

    return comparations[task.priority];
  }

  Map<String, dynamic> toMap() {
    final taskMap =  {
      'name': name,
      'priority': priority,
      'to': to,
      'from': from,
      'description': description,
    };

    if(id != null) taskMap['id'] = id.toString();
    
    return taskMap;
  }

  static Task fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Task(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      to: map['to'],
      from: map['from'],
      description: map['description'],
      isDone: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Task(id: $id, name: $name, priority: $priority, to: $to, from: $from, description: $description, isDone: $isDone)';
  }
}
