class Task {
  int id;
  String name;
  // TODO think enum or String
  String priority;
  String to;
  String from;
  String description;
  bool isDone;
  Task({this.name, this.priority, this.to, this.from});

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
}
