import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class EspecialidadeHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Especialidade> createEspecialidade(Especialidade especialidade) async{
    Database db = await _dbConn.getDb;
    especialidade.id = await db.insert(especialidadeTable, especialidade.toMap());
    return especialidade;
  }

  Future<Especialidade> readEspecialidade(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(especialidadeTable,
        columns: ["id", "descricao"],
        where: "id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0){
      return Especialidade.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updateEspecialidade(Especialidade especialidade) async {
    Database db = await _dbConn.getDb;
    return await db.update(especialidadeTable, especialidade.toMap(),
        where: "id = ?",
        whereArgs: [especialidade.id]
    );
  }

  Future<int> deleteEspecialidade(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(especialidadeTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List> getAllEspecialidade() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $especialidadeTable");
    List<Especialidade> listEspecialidade = List();

    for (Map m in listMap){
      listEspecialidade.add(Especialidade.fromMap(m));
    }
    return listEspecialidade;
  }

}


class Especialidade{
  int id;
  String descricao;

  Especialidade(this.descricao){}

  Especialidade.fromMap(Map map){
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
    return "{ID: $id; Descricao: $descricao}";
  }


}