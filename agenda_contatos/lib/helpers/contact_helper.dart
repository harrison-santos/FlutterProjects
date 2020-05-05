import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

final String contactTable = "contacts";
final String idColumn = "id";
final String nameColumn = "name";
final String emailColumn = "email";
final String phoneColumn = "phone";
final String imgColumn = "img";

class ContactHelper{
  //Classe singleton - So possui um objeto em todo o seu codigo
  static final ContactHelper _instance = ContactHelper.internal();//Objeto da minhas propria classe

  factory ContactHelper() => _instance;
  //singleton
  ContactHelper.internal();

  Database _db;

  Future<Database> initDb () async{
    final databasesPath = await getDatabasesPath();//Espera o path chegar antes de continuar(Necessrio funcao async)
    final path = join(databasesPath, "contactsnew.db");
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
            "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, "
                "$phoneColumn TEXT, $imgColumn TEXT)"
          );

        });
  }

  Future<Contact> saveContact(Contact contact) async{
    Database dbContact = await getDb;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async{
    Database dbContact = await getDb;
    List<Map> maps = await dbContact.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );
    if (maps.length > 0){
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deleteContact(int id ) async{
    Database dbContact = await getDb;
    return await dbContact.delete(contactTable,
      where: "$idColumn = ?",
      whereArgs: [id]
    );
  }

  Future<int> updateContact(Contact contact) async{
    Database dbContact = await getDb;
    return await dbContact.update(contactTable, contact.toMap(),
      where: "$idColumn = ?",
      whereArgs: [contact.id]
    );
  }

  Future<Database> get getDb async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }//End Function

  Future<List> getAllContact() async{
    Database dbContact = await getDb;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async{
    Database dbContact = await getDb;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future closeDb () async {
    Database dbContact = await getDb;
    dbContact.close();
  }
}

class Contact{
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact(){}
  //Pega de map e passa para o contato object
  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }


  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    return map;
  }

  @override
  String toString() {
    return name;
  } //End Function



}