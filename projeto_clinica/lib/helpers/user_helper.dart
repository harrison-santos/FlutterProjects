import "dart:async";
import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class UserHelper{
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();

  Future<int> createUser(User user) async {
    Database db = await _dbConn.getDb;
    int result = await db.insert(userTable, user.toMap());
    return result;
  }

  Future<int> deleteUser(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(userTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<User> getLogin(String username, String password) async{
    Database db = await _dbConn.getDb;
    var result = await db.query(userTable,
      where: "username = ? and password = ?",
      whereArgs: [username, password]
    );

    if (result.length > 0){
      return User.fromMap(result.first);
    }else{
      return null;
    }
  }

}

class User{
  int id;
  String _username;
  String _password;


  User(this._username, this._password);

  User.fromMap(Map map){
    this._username = map["username"];
    this._password = map["password"];
  }

  String get username => username;
  String get password => password;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    return map;

  }
}

