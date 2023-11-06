import 'package:contact/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final DataBaseHelper _dataBaseHelper = DataBaseHelper._init();

  factory DataBaseHelper() => _dataBaseHelper;
  static Database? _db;

  DataBaseHelper._init();

  Future<Database> get AsosiyDB async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();

    return _db!;
  }

  _initDb() async {
    /// Bazani yo'lni oladi
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'todo.db');
    print(dataBasePath);
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE myTodo('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'phone TEXT'
        ')');
  }

  Future<int> saveContact(ContactModel item) async {
    var dbClient = await AsosiyDB;
    var result = dbClient.insert('myTodo', item.toJson());
    return result;
  }

  Future<List<ContactModel>> malumotlarniolish() async {
    var dbClient = await AsosiyDB;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM myTodo');
    List<ContactModel> data = [];
    for (int i = 0; i < list.length; i++) {
      ContactModel contactModel = ContactModel(
        id: list[i]['id'],
        name: list[i]['name'],
        phone: list[i]['phone'],
      );
      data.add(contactModel);
    }
    return data;
  }


  Future<int> updateBase(ContactModel item)async{
    var db = await AsosiyDB;
    var res = db.update('myTodo', item.toJson(),where: 'id = ?' ,whereArgs: [item.id]);
    return res;
  }
  Future<int> deleteBase(id)async{
    var db = await AsosiyDB;
    var res = db.delete('myTodo',where: 'id = ?' ,whereArgs: [id]);
    return res;
  }

}
