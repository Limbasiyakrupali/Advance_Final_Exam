import 'package:advance_final_exam/model/recipes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? db;

  Future<void> initDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath);

    db = await openDatabase(path, version: 1, onCreate: (Database db, version) {
      String quary =
          "CREATE TABLE IF NOT EXISTS recipes(id AUTOINCREMENT PRIMARY KEY INTEGER, quantity INTEGER NOT NULL, name TEXT NOT NULL, type TEXT NOT NULL);";
      print("==========");
      print(quary);
      print("==========");
      db.execute(quary);
    });
  }

  Future<void> insertDb(RecipesModel recipesmodel) async {
    if (db == null) {
      await initDb();
    }
    String quary =
        "INSERT INTO recipes(id AUTOINCREMENT PRIMARY KEY INTEGER, quantity TEXT NOT NULL, name TEXT NOT NULL,type TEXT NOT NULL) VALUES(?,?,?);";
    List args = [
      recipesmodel.quantity,
      recipesmodel.type,
      recipesmodel.name,
      recipesmodel.id
    ];
    await db?.rawInsert(quary, args);
  }

  Future<List<RecipesModel>>? fetchallDb() async {
    if (db == null) {
      await initDb();
    }
    String quary =
        "SELECT FROM recipes(quantity TEXT NOT NULL, name TEXT NOT NULL,type TEXT NOT NULL) WHERE id = ?";
    List alldata = await db!.rawQuery(quary);
    List<RecipesModel> recipemodel =
        alldata.map((e) => RecipesModel.fromMap(data: e)).toList();
    return recipemodel;
  }

  Future<void> deleteDb(int id) async {
    if (db == null) {
      await initDb();
    }
    String quary =
        "DELETE FROM recipes(quantity TEXT NOT NULL, name TEXT NOT NULL,type TEXT NOT NULL) WHERE id = ?);";
    List args = [id];

    await db?.rawDelete(quary, args);
  }

  Future<void> deleteAllDb() async {
    if (db == null) {
      await initDb();
    }

    String quary = "DELETE FROM recipes;";
    await db?.rawDelete(quary);
  }

  Future<void> updateDb(RecipesModel recipesmodel) async {
    if (db == null) {
      await initDb();
    }
    String quary =
        "SELECT FROM SET recipes(quantity TEXT NOT NULL, name TEXT NOT NULL,type TEXT NOT NULL) WHERE ID = ?";
    List args = [recipesmodel.quantity, recipesmodel.type, recipesmodel.name];

    await db?.rawUpdate(quary, args);
  }
}
