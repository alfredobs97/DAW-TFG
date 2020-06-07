import 'package:flutter/material.dart';
import 'package:your_tasks/bloc/login_bloc/login_bloc.dart';
import 'package:your_tasks/bloc/task_bloc/task_bloc.dart';
import 'package:your_tasks/bloc/user_bloc/user_bloc.dart';
import 'package:your_tasks/models/task-model.dart';
import 'package:your_tasks/models/user-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/widgets/snackbars.dart';

class NewTask extends StatefulWidget {
  final Task taskEditing;

  const NewTask({Key key, this.taskEditing}) : super(key: key);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _priority = 'low';

  List<Widget> _createUserChips(List<User> users) {
    return users
        .map((user) => ActionChip(
            label: Text(user.username),
            avatar: Icon(Icons.remove),
            onPressed: () {
              context.bloc<UserBloc>().add(RemoveSelectedUser(user.username));
            }))
        .toList();
  }

  void _generateTask() {
    final task = Task(
        name: _titleController.text,
        priority: _priority,
        description: _descriptionController.text,
        to: (context.bloc<UserBloc>().state as UsersAsigned).users[0].username,
        from: (context.bloc<LoginBloc>().state as Logged).username);

    if (widget.taskEditing != null) task.id = widget.taskEditing.id;

    widget.taskEditing == null
        ? context.bloc<TaskBloc>().add(CreateTask(task))
        : context.bloc<TaskBloc>().add(ModifyTask(task));

    _cleanForm();
  }

  void _cleanForm() {
    context.bloc<UserBloc>().add(ClearSelectedUsers());
    _formKey.currentState.reset();
  }

  void _insertFieldsFromTask() {
    _titleController.text = widget.taskEditing.name;
    _descriptionController.text = widget.taskEditing.description;
    _priority = widget.taskEditing.priority;
    context.bloc<UserBloc>().add(UsersSelected([User(username: widget.taskEditing.to)]));
  }

  bool _isSomeUserSelected() {
    return (context.bloc<UserBloc>().state as UsersAsigned).users.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.taskEditing != null) _insertFieldsFromTask();

    return BlocListener<TaskBloc, TaskState>(
        listener: (context, state) async {
          if (state is ErrorCreatingTask) _scaffoldKey.currentState.showSnackBar(SnackBars.errorTask);
          if (state is TaskCreated) _scaffoldKey.currentState.showSnackBar(SnackBars.taskSend);
          if (state is TaskModified) {
            _scaffoldKey.currentState.showSnackBar(SnackBars.modifiedTask);
            await Future.delayed(Duration(seconds: 1));
            Navigator.maybePop(context);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: widget.taskEditing != null
              ? AppBar(
                  title: Text('Edita tu tarea'),
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    onChanged: (String _) {
                      _formKey.currentState.validate();
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'El nombre de la tarea no puede estar vacío' : null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Titulo de la tarea',
                        labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Prioridad de la tarea:'),
                      DropdownButton(
                          value: _priority,
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
                            _priority = value;
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
                      gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor]),
                    ),
                    child: FlatButton(
                      child: Text(
                        'Asignar usuarios',
                      ),
                      onPressed: () {
                        context.bloc<UserBloc>().add(FetchUsers());
                        Navigator.pushNamed(context, '/searchUsers');
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Usuarios asignados: '),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UsersAsigned)
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _createUserChips(state.users),
                            );
                          return Container();
                        },
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLines: 10,
                      onChanged: (String _) {
                        _formKey.currentState.validate();
                      },
                      validator: (String value) {
                        return value.isEmpty ? 'La descripción de la tarea no puede estar vacía' : null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3.0),
                          ),
                          labelText: 'Descripción de la tarea',
                          labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
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
                      gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor]),
                    ),
                    child: FlatButton(
                        child: Text('Enviar'),
                        onPressed: () {
                          //todo controlate this return
                          if (_isSomeUserSelected()) {
                            return _scaffoldKey.currentState.showSnackBar(SnackBars.noUsers);
                          }
                          if (_formKey.currentState.validate()) {
                            _generateTask();
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
