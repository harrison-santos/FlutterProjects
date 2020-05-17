import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class ConsultaHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Consulta> createConsulta(Consulta consulta) async{
    Database db = await _dbConn.getDb;
    consulta.id = await db.insert(consultaTable, consulta.toMap());
    return consulta;
  }

  Future<Consulta> readConsulta(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(consultaTable,
        columns: ["id", "data", "cobertura_id", "medico_id", "paciente_id"],
        where: "id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0){
      return Consulta.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updateConsulta(Consulta consulta) async {
    Database db = await _dbConn.getDb;
    return await db.update(consultaTable, consulta.toMap(),
        where: "id = ?",
        whereArgs: [consulta.id]
    );
  }

  Future<int> deleteConsulta(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(consultaTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List> getAllConsulta() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $consultaTable");
    List<Consulta> listConsulta = List();

    for (Map m in listMap){
      listConsulta.add(Consulta.fromMap(m));
    }
    return listConsulta;
  }

}


class Consulta{
  int id;
  String data;
  int cobertura_id;
  int medico_id;
  int paciente_id;

  Consulta(){}

  Consulta.fromMap(Map map){
    id = map["id"];
    data = map["data"];
    cobertura_id= map["cobertura_id"];
    medico_id = map["medico_id"];
    paciente_id = map["paciente_id"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "id": id,
      "data": data,
      "cobertura_id": cobertura_id,
      "medico_id": medico_id,
      "paciente_id": paciente_id,
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Medico: $medico_id; Paciente: $paciente_id; Data: $data}";
  }


}