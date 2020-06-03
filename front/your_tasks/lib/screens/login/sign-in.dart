import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_tasks/exceptions/invalid-login.dart';
import 'package:your_tasks/providers/login-provider.dart';
import 'package:your_tasks/providers/token-provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Column(
      children: <Widget>[
        TextField(
          controller: usernameController,
          style: TextStyle(fontSize: 30.0, height: 2),
          autofocus: true,
          textCapitalization: TextCapitalization.none,
          cursorColor: Theme.of(context).accentColor,
          decoration: InputDecoration(
              hintText: 'Username', prefixIcon: Icon(Icons.perm_identity)),
        ),
        TextField(
          controller: passController,
          style: TextStyle(fontSize: 30.0, height: 2),
          obscureText: true,
          cursorColor: Theme.of(context).accentColor,
          decoration: InputDecoration(
              hintText: 'Password', prefixIcon: Icon(Icons.https)),
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
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ]),
              ),
              child: FlatButton(
                  onPressed: () async {
                    loginProvider.addCredentials(
                        usernameController.text, passController.text);

                    try {
                      await loginProvider.login();

                      TokenProvicer.saveToken(loginProvider.token);
                      

                      Navigator.pushNamed(context, '/home');
                    } on LoginInvalidException {
                      final snackBar = SnackBar(
                          content: Text('Usuario o contraseña incorrectos'));

                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Login')),
            ))
      ],
    );
  }
}
