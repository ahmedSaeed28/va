import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:va/base/data/Equation.dart';
import '../app/CommonImports.dart';
import 'package:va/contstants/DatabaseConstants.dart';

class AppDatabase{

  Database _database;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'va.db'),
      onCreate: (db, version) {
        return db.execute(
        "CREATE TABLE " + tableName + "(" + idCollum +
            " INTEGER PRIMARY KEY, " + firstNumberColumn +
            " INTEGER, " + secondNumberColumn + " INTEGER, " +
            resultColumn + " INTEGER, " + operationTypeColumn + " INTEGER, " +
            finishingTimeColumn + " TEXT, " + doneColumn + " INTEGER)",
        );
      },
      version: 1,
    );
    _database = await database;
  }

  Future<void> insertEquation(Equation equation) async {
    print(equation.id);
    await _database.insert(
      tableName,
      equation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEquation(Equation equation) async {
    await _database.update(
      tableName,
      equation.toMap(),
      where: idCollum + " = ?",
      whereArgs: [equation.id.toString()],
    );
  }

  Future<List<Equation>> getEquations() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);
    return List.generate(maps.length, (i) {
      return Equation(
          id: maps[i][idCollum],
          firstNumber: maps[i][firstNumberColumn],
          secondNumber: maps[i][secondNumberColumn],
          operationType: maps[i][operationTypeColumn],
          finishingTime: maps[i][finishingTimeColumn],
          result: maps[i][resultColumn],
          done: maps[i][doneColumn]
      );
    });
  }

  Future<void> deleteEquation(int id) async {
    await _database.delete(
      tableName,
      where: idCollum + " = ?",
      whereArgs: [id],
    );
  }
}
