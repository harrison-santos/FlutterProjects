import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

//TABLES
final String userTable = "user";
final String especialidadeTable = "especialidade";
final String medicoTable = "medico";
final String pagamentoTable = "pagamento";
final String consultaTable = "consulta";
final String consulta_pagamentoTable = "consulta_pagamento";
final String coberturaTable = "cobertura";
final String receita_medicaTable = "receita_medica";
final String formas_pagamentoTable = "formas_pagamento";
final String pacienteTable = "paciente";
final requisicao_exameTable = "requisiscao_exame";
final enderecoTable = "endereco";
//

//FIELDS
final String user_fields = ""
    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
    "username TEXT,"
    "password TEXT";
final String especialidade_fields = "id INTEGER PRIMARY KEY, descricao TEXT";
final String medico_fields =  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
    "nome TEXT, crm TEXT, "
    "especialidade_id INTEGER, "
    "FOREIGN KEY (especialidade_id) REFERENCES especialidade (id)";
final String pagamento_fields = "id INTEGER PRIMARY KEY, valor FLOAT, data DATE, "
    "formas_pagamento_id INTEGER, "
    "FOREIGN KEY(formas_pagamento_id) REFERENCES formas_pagamento(id)";
final String consulta_fields = "id INTEGER PRIMARY KEY, data DATE, "
    "cobertura_id INTEGER,"
    "medico_id INTEGER, "
    "paciente_id INTEGER, "
    "FOREIGN KEY(cobertura_id) REFERENCES cobertura(id), "
    "FOREIGN KEY(medico_id) REFERENCES medico(id), "
    "FOREIGN KEY(paciente_id) REFERENCES paciente(id)";

final String consulta_pagamento_fields = "id INTEGER PRIMARY KEY,  "
    "pagamento_id INTEGER,"
    "consulta_id INTEGER, "
    "FOREIGN KEY(pagamento_id) REFERENCES pagamento(id), "
    "FOREIGN KEY(consulta_id) REFERENCES consulta(id)";
final String cobertura_fields = "id INTEGER PRIMARY KEY, descricao TEXT";
final String receita_medica_fields = "id INTEGER PRIMARY KEY, descricao TEXT, data DATE, "
    "consulta_id INTEGER, "
    "FOREIGN KEY(consulta_id) REFERENCES consulta(id)";
final String formas_pagamento_fields = "id INTEGER PRIMARY KEY, descricao TEXT";
final String paciente_fields = "id INTEGER PRIMARY KEY AUTOINCREMENT, "
    "nome TEXT, "
    "dt_nascimento TEXT, "
    "rg TEXT, cpf TEXT, "
    "cidade TEXT,"
    "bairro TEXT,"
    "rua TEXT,"
    "numero TEXT";
final String requisicao_exame_fields = "id INTEGER PRIMARY KEY, descricao TEXT, data DATE";
//final String endereco_fields = "id INTEGER PRIMARY KEY, rua TEXT, bairro TEXT, numero TEXT";
//

class CustomDatabaseConnection{
  Database _db;

  Future<Database> initDb() async{
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "user4.db");

    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int newerVersion) async{
          await db.execute("CREATE TABLE $userTable($user_fields)");
          await db.execute("CREATE TABLE $especialidadeTable($especialidade_fields)");
          await db.execute("CREATE TABLE $medicoTable($medico_fields)");
          await db.execute("CREATE TABLE $pagamentoTable($pagamento_fields)");
          await db.execute("CREATE TABLE $consultaTable($consulta_fields)");
          await db.execute("CREATE TABLE $consulta_pagamentoTable($consulta_pagamento_fields)");
          await db.execute("CREATE TABLE $coberturaTable($cobertura_fields)");
          await db.execute("CREATE TABLE $receita_medicaTable($receita_medica_fields)");
          await db.execute("CREATE TABLE $formas_pagamentoTable($formas_pagamento_fields)");
          await db.execute("CREATE TABLE $pacienteTable($paciente_fields)");
          await db.execute("CREATE TABLE $requisicao_exameTable($requisicao_exame_fields)");
          //await db.execute("CREATE TABLE $enderecoTable($endereco_fields)");
        });
  }//END FUNCTION

  Future<Database> get getDb async {
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }

  }

  Future closeDb() async {
    Database dbClinica = await getDb;
    dbClinica.close();
  }
}