import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_tasks/bloc/login_bloc/login_bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is InvalidLogin) {
            final snackBar = SnackBar(content: Text('Usuario o contraseña incorrectos'));

            Scaffold.of(context).showSnackBar(snackBar);
          }
          if (state is LogginIn) {
            final snackBar = SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircularProgressIndicator(), Text('Iniciando sesión...')],
            ));

            Scaffold.of(context).showSnackBar(snackBar);
          }
          if (state is Logged) Navigator.pushNamed(context, '/home');
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
                        context.repository<LoginBloc>().add(Login(usernameController.text, passController.text));
                      },
                      child: Text('Login')),
                ))
          ],
        ));
  }
}
