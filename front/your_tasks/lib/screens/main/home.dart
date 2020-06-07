import 'package:flutter/material.dart';
import 'package:your_tasks/screens/main/list-task.dart';
import 'package:your_tasks/screens/main/new-task.dart';

class HomeTask extends StatefulWidget {
  @override
  _HomeTaskState createState() => _HomeTaskState();
}

class _HomeTaskState extends State<HomeTask> {
  int index = 0;
  final List<Widget> screens = [ListTask(), NewTask()];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 660 ? _homeWeb() : _homeMobile();
    });
  }

  _homeMobile() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba'),
        centerTitle: true,
      ),
      body: IndexedStack(
        children: screens,
        index: index,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Tareas')),
          BottomNavigationBarItem(icon: Icon(Icons.edit), title: Text('Asignar'))
        ],
        currentIndex: index,
        onTap: (int indexNow) {
          index = indexNow;

          setState(() {});
        },
      ),
    );
  }

  _homeWeb() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba'),
        centerTitle: true,
      ),
      body: IndexedStack(
        children: screens,
        index: index,
      ),
      //drawerScrimColor: Colors.redAccent,
      //drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text('Gestiona tus tareas')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Tareas'),
              onTap: () {
                index = 0;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Asignar'),
              onTap: () {
                index = 1;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Salir'),
              onTap: () {
                // sale del draw y de la parte del login
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
