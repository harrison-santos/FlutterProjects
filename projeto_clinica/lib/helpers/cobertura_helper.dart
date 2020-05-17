import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class CoberturaHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Cobertura> createCobertura(Cobertura cobertura) async{
    Database db = await _dbConn.getDb;
    cobertura.id = await db.insert(coberturaTable, cobertura.toMap());
    return cobertura;
  }

  Future<Cobertura> readCobertura(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(coberturaTable,
        columns: ["id", "descricao"],
        where: "id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0){
      return Cobertura.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updateCobertura(Cobertura cobertura) async {
    Database db = await _dbConn.getDb;
    return await db.update(coberturaTable, cobertura.toMap(),
        where: "id = ?",
        whereArgs: [cobertura.id]
    );
  }

  Future<int> deleteCobertura(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(coberturaTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List> getAllCobertura() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $coberturaTable");
    List<Cobertura> listCobertura = List();

    for (Map m in listMap){
      listCobertura.add(Cobertura.fromMap(m));
    }
    return listCobertura;
  }

}


class Cobertura{
  int id;
  String descricao;

  Cobertura(){}

  Cobertura.fromMap(Map map){
    id = map["id"];
    descricao = map["descricao"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "id": id,
      "descricao": descricao,
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Nome: $descricao}";
  }


}