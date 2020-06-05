import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/bloc/register_bloc/register_bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final telController = TextEditingController();
  final passController = TextEditingController();

  final snackBarError = SnackBar(content: Text('Servidor no disponible en este momento'));
  final snackBarSuccess = SnackBar(content: Text('Registro completado'));
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is ErrorRegistered) Scaffold.of(context).showSnackBar(snackBarError);
        if (state is Registered) Scaffold.of(context).showSnackBar(snackBarSuccess);
      },
      child: Column(
        children: <Widget>[
          TextField(
            controller: usernameController,
            style: TextStyle(fontSize: 30.0, height: 2),
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(hintText: 'Username', prefixIcon: Icon(Icons.perm_identity)),
          ),
          TextField(
            controller: nameController,
            style: TextStyle(fontSize: 30.0, height: 2),
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(hintText: 'Nombre', prefixIcon: Icon(Icons.face)),
          ),
          TextField(
            controller: telController,
            style: TextStyle(fontSize: 30.0, height: 2),
            keyboardType: TextInputType.phone,
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(hintText: 'Teléfono', prefixIcon: Icon(Icons.phone)),
          ),
          TextField(
            controller: passController,
            style: TextStyle(fontSize: 30.0, height: 2),
            obscureText: true,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.https)),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
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
                    onPressed: () async {
                      context.repository<RegisterBloc>().add(Register(
                          username: usernameController.text,
                          name: nameController.text,
                          password: passController.text,
                          phone: int.parse(telController.text)));
                    },
                    child: Text('Registrar')),
              ))
        ],
      ),
    );
  }
}
