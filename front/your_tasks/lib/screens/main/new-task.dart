import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/providers/login-provider.dart';
import 'package:your_tasks/providers/task-provider.dart';
import 'package:your_tasks/providers/user-provider.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  List<Widget> toUsers = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String priority = 'low';
  final _formKey = GlobalKey<FormState>();
  final snackBarNoUsers = SnackBar(content: Text('Debe asignar un usuario'));
  final snackBarTaskSend = SnackBar(content: Text('¡Tarea asignada!'));
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final Task taskEditing = ModalRoute.of(context).settings.arguments;

    _createUserChips() {
      this.toUsers = userProvider
          .usersSelected()
          .map((user) => ActionChip(
              label: Text(user.username),
              avatar: Icon(Icons.remove),
              onPressed: () {
                user.isSelected = false;
                this.toUsers.remove(user);
                _createUserChips();
                setState(() {});
              }))
          .toList();
    }

    _generateTask() {
      // todo change when construct task
      //todo think to multiple users
      Map<String, String> task = {
        'name': titleController.text,
        'priority': priority,
        'description': descriptionController.text,
        'to': userProvider.usersSelected()[0].username,
        'from': loginProvider.username,
      };

      taskEditing == null
          ? taskProvider.createTask(task)
          : taskProvider.modifyTask(task);
    }

    _insertFieldsFromTask() {
      titleController.text = taskEditing.name;
      descriptionController.text = taskEditing.description;
      priority = taskEditing.priority;
      // todo User list
      userProvider.selectUsers([taskEditing.to]);
      // todo check actions chips dont remove
      _createUserChips();
    }

    if (taskEditing != null) _insertFieldsFromTask();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        appBar: taskEditing != null
            ? AppBar(
                title: Text('Edita tu tarea'),
              )
            : null,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextFormField(
                controller: titleController,
                onChanged: (String _) {
                  _formKey.currentState.validate();
                },
                validator: (String value) {
                  return value.isEmpty
                      ? 'El nombre de la tarea no puede estar vacío'
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Titulo de la tarea',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Prioridad de la tarea:'),
                  DropdownButton(
                      value: priority,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Theme.of(context).primaryColor,
                      iconSize: 30,
                      hint: Text('Prioridad'),
                      disabledHint: Text('Debe seleccionar una prioridad'),
                      items: [
                        DropdownMenuItem(
                          child: Text('Baja'),
                          value: 'low',
                        ),
                        DropdownMenuItem(
                          child: Text('Media'),
                          value: 'medium',
                        ),
                        DropdownMenuItem(
                          child: Text('Alta'),
                          value: 'high',
                        ),
                      ],
                      onChanged: (String value) {
                        priority = value;
                        setState(() {});
                      }),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 5.0,
                      offset: Offset(3.0, 1.0),
                    )
                  ],
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),
                ),
                child: FlatButton(
                  child: Text(
                    'Asignar usuarios',
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/searchUsers').then((_) {
                      _createUserChips();
                      //userProvider.unselectUsers();
                      setState(() {});
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Usuarios asignados: '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: toUsers,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 10,
                  onChanged: (String _) {
                    _formKey.currentState.validate();
                  },
                  validator: (String value) {
                    return value.isEmpty
                        ? 'La descripción de la tarea no puede estar vacía'
                        : null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 3.0),
                      ),
                      labelText: 'Descripción de la tarea',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 5.0,
                      offset: Offset(3.0, 1.0),
                    )
                  ],
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),
                ),
                child: FlatButton(
                    child: Text('Enviar'),
                    onPressed: () {
                      if (toUsers.length == 0) {
                        return Scaffold.of(context)
                            .showSnackBar(snackBarNoUsers);
                      }
                      if (_formKey.currentState.validate()) {
                        _generateTask();
                        toUsers = [];
                        userProvider.unselectUsers();
                        return Scaffold.of(context)
                            .showSnackBar(snackBarTaskSend);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
