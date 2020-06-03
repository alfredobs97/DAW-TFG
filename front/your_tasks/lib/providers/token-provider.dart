import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TokenProvicer {
  static final String dbPath = 'token.db';
  static final DatabaseFactory dbFactory = databaseFactoryIo;

  static saveToken(String token) {
    kIsWeb ? __saveTokenWeb(token) : __saveTokenMobilDesktop(token);
  }

  static loadToken() {
    return kIsWeb ? __loadTokenWeb() : __loadTokenMobilDesktop();
  }

  static __saveTokenMobilDesktop(String token) async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();

    await store.record('token').put(db, token);
  }

  static __saveTokenWeb(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  static __loadTokenMobilDesktop() async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();

    return await store.record('token').get(db) as String;
  }

  static __loadTokenWeb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getString('token');
  }
}
