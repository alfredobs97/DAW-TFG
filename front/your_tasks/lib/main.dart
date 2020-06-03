import 'package:flutter/material.dart';
import 'package:your_tasks/providers/login-provider.dart';
import 'package:your_tasks/providers/task-provider.dart';
import 'package:your_tasks/providers/user-provider.dart';
import 'package:your_tasks/screens/login/login.dart';
import 'package:your_tasks/screens/main/home.dart';
import 'package:your_tasks/screens/main/new-task.dart';
import 'package:your_tasks/screens/main/task-user.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => UserProvider()),
      Provider(create: (context) => LoginProvider()),
       Provider(create: (context) => TaskProvider()),
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.tealAccent[400],
          backgroundColor: Colors.white),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeTask(),
        '/searchUsers' : (context) => AddUserTask(),
        '/newTask' : (context) => NewTask() 
      },
    ));
  }
}

