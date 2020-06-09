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
      columns: ["id", "nome", "dt_nascimento", "rg", "cpf", "cidade", "bairro", "numero", "numero"],
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
  String cidade;
  String bairro;
  String rua;
  String numero;//FOREIGN KEY

  Paciente(){}

  Paciente.fromMap(Map map){
    id = map["id"];
    nome = map["nome"];
    dt_nascimento = map["dt_nascimento"];
    rg = map["rg"];
    cpf = map["cpf"];
    cidade = map["cidade"];
    bairro = map["bairro"];
    rua = map["rua"];
    numero = map["numero"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "id": id,
      "nome": nome,
      "dt_nascimento": dt_nascimento,
      "rg": rg,
      "cpf": cpf,
      "cidade": cidade,
      "bairro": bairro,
      "rua": rua,
      "numero": numero
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Nome: $nome; DT: $dt_nascimento; RG: $rg; CPF: $cpf;}";
  }


}