import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class PacienteHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Paciente> createPaciente(Paciente paciente) async{
    Database db = await _dbConn.getDb;
    paciente.id = await db.insert(pacienteTable, paciente.toMap());
    return paciente;
  }

  Future<Paciente> readPaciente(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(pacienteTable,
      columns: ["id", "nome", "dt_nascimento", "rg", "cpf", "endereco_id"],
      where: "id = ?",
      whereArgs: [id]
    );
    if (maps.length > 0){
      return Paciente.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updatePaciente(Paciente paciente) async {
    Database db = await _dbConn.getDb;
    return await db.update(pacienteTable, paciente.toMap(),
      where: "id = ?",
      whereArgs: [paciente.id]
    );
  }

  Future<int> deletePaciente(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(pacienteTable,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<List> getAllPaciente() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $pacienteTable");
    List<Paciente> listPaciente = List();

    for (Map m in listMap){
      listPaciente.add(Paciente.fromMap(m));
    }
    return listPaciente;
  }

}


class Paciente{
  int id;
  String nome;
  String dt_nascimento;
  String rg;
  String cpf;
  String endereco_id;//FOREIGN KEY

  Paciente(){}

  Paciente.fromMap(Map map){
    id = map["id"];
    nome = map["nome"];
    dt_nascimento = map["dt_nascimento"];
    rg = map["rg"];
    cpf = map["cpf"];
    endereco_id = map["endereco_id"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": nome,
      "dt_nascimento": dt_nascimento,
      "rg": rg,
      "cpf": cpf,
      "endereco_id": endereco_id
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Nome: $nome; DT: $dt_nascimento; RG: $rg; CPF: $cpf; Endereco: $endereco_id}";
  }


}