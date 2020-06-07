import 'package:flutter/material.dart';

class SnackBars {
  static final noUsers = SnackBar(content: Text('Debe asignar un usuario'));
  static final taskSend = SnackBar(content: Text('¡Tarea asignada!'));
  static final errorTask = SnackBar(content: Text('¡Error creando la tarea!'));
  static final modifiedTask = SnackBar(content: Text('Tarea modificada'));
  static final errorLogin = SnackBar(content: Text('Usuario o contraseña incorrectos'));
  static final loginIn = SnackBar(
      content: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      CircularProgressIndicator(),
      Text('Iniciando sesión...'),
    ],
  ));
}
