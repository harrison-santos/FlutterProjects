import "package:projetoclinica/helpers/db_connection.dart";
import "package:sqflite/sqflite.dart";

class PagamentoHelper {
  CustomDatabaseConnection _dbConn =  CustomDatabaseConnection();


  Future<Pagamento> createPagamento(Pagamento pagamento) async{
    Database db = await _dbConn.getDb;
    pagamento.id = await db.insert(pagamentoTable, pagamento.toMap());
    return pagamento;
  }

  Future<Pagamento> readPagamento(int id) async {
    Database db = await _dbConn.getDb;
    List<Map> maps = await db.query(pagamentoTable,
        columns: ["valor", "data", "formas_pagamento_id"],
        where: "id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0){
      return Pagamento.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updatePagamento(Pagamento pagamento) async {
    Database db = await _dbConn.getDb;
    return await db.update(pagamentoTable, pagamento.toMap(),
        where: "id = ?",
        whereArgs: [pagamento.id]
    );
  }

  Future<int> deletePagamento(int id) async{
    Database db = await _dbConn.getDb;
    return await db.delete(pagamentoTable,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List> getAllPagamento() async{
    Database db = await _dbConn.getDb;
    List listMap = await db.rawQuery("SELECT * FROM $pagamentoTable");
    List<Pagamento> listPagamento = List();

    for (Map m in listMap){
      listPagamento.add(Pagamento.fromMap(m));
    }
    return listPagamento;
  }

}


class Pagamento{
  int id;
  double valor;
  String data;
  int formas_pagamento_id;

  Pagamento(){}

  Pagamento.fromMap(Map map){
    id = map["id"];
    valor = map["valor"];
    data = map["data"];
    formas_pagamento_id = map["formas_pagamento_id"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "id": id,
      "valor": valor,
      "data": data,
      "formas_pagamento_id": formas_pagamento_id
    };
    return map;
  }

  @override
  String toString() {
    return "{ID: $id; Valor: $valor; Data: $data; formas_pagamento_id: $formas_pagamento_id}";
  }


}