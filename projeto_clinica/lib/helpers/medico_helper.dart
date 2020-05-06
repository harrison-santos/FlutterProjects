import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class MedicoHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Medico> createMedico(Medico medico) async{
    Database db = await _dbConn.getDb;
    medico.id = await db.insert(medicoTable, medico.toMap());
    return medico;
  }

  Future<Medico> readMedico(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(medicoTable,
        columns: ["id", "nome", "crm", "especialidade_id"],
        where: "id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0){
      return Medico.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updateMedico(Medico medico) async {
    Database db = await _dbConn.getDb;
    return await db.update(medicoTable, medico.toMap(),
        where: "id = ?",
        whereArgs: [medico.id]
    );
  }

  Future<int> deleteMedico(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(medicoTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List> getAllMedico() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $medicoTable");
    List<Medico> listMedico = List();

    for (Map m in listMap){
      listMedico.add(Medico.fromMap(m));
    }
    return listMedico;
  }

}


class Medico{
  int id;
  String nome;
  String crm;
  int especialidade_id;

  Medico(){}

  Medico.fromMap(Map map){
    id = map["id"];
    nome = map["nome"];
    crm= map["crm"];
    especialidade_id = map["especialidade_id"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": nome,
      "crm": crm,
      "especialidade_id": especialidade_id,
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Nome: $nome}";
  }


}