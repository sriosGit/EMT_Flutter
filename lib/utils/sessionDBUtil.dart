import 'dart:io';

import 'package:EMT/models/Session.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SessionDBUtil {
  SessionDBUtil._();

  static final SessionDBUtil db = SessionDBUtil._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "sessions.db");
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE sessions(id INTEGER PRIMARY KEY AUTOINCREMENT, idEstudiante INTEGER, token TEXT, idFacebook TEXT, tokenFacebook TEXT  )");
    });
  }

  addSessionToDatabase(session) async {
    final db = await database;
    Map<String, dynamic> row = {
      "idEstudiante": session["idEstudiante"],
      "token": session["token"],
      "idFacebook": session["idFacebook"],
      "tokenFacebook": session["tokenFacebook"],
    };
    var raw = await db.insert(
      "sessions",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateSession(Session session) async {
    final db = await database;
    var response = await db.update("sessions", session.toJson(),
        where: "idEstudiante = ?", whereArgs: [session.idEstudiante]);
    return response;
  }

  Future<Session> getSessionWithidEstudiante(int idEstudiante) async {
    final db = await database;
    var response = await db.query("sessions",
        where: "idEstudiante = ?", whereArgs: [idEstudiante]);
    return response.isNotEmpty ? Session.fromJson(response.first) : null;
  }

  Future<List<Session>> getAllSessions() async {
    final db = await database;
    var response = await db.query("sessions");
    List<Session> list = response.map((c) => Session.fromJson(c)).toList();
    return list;
  }

  deleteSessionWithId(int userId) async {
    final db = await database;
    return db
        .delete("sessions", where: "idEstudiante = ?", whereArgs: [userId]);
  }

  deleteAllSession() async {
    final db = await database;
    db.execute("delete from sessions");
  }
}
