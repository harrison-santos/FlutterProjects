import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:projetoclinica/helpers/pagamento_helper.dart";
import 'package:projetoclinica/ui/pagamento/pagamento_page.dart';


class ListagemPagamento extends StatefulWidget {
  @override
  _ListagemPagamentoState createState() => _ListagemPagamentoState();
}

class _ListagemPagamentoState extends State<ListagemPagamento> {
  PagamentoHelper pagamentoHelper = PagamentoHelper();
  List<Pagamento> pagamentos = List();

  @override
  void initState()  {
    super.initState();

    _getAllPagamentos();

    /*
    Pagamento pagamento = Pagamento();
    pagamento.nome = "Doutor ney";
    pagamento.crm = "1234567";
    pagamento.especialidade_id = 1;
    pagamentoHelper.createPagamento(pagamento);
     */


    /*
    pagamentoHelper.readPagamento(1).then((p1){
      p1.nome = "Harrison";
      pagamentoHelper.updatePagamento(p1).then((p1){
        print(p1);
      });
    });
    */
    //pagamentoHelper.deletePagamento(1);

    pagamentoHelper.getAllPagamento().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de Pagamentos"),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: pagamentos.length,
          itemBuilder: (context, index){
            return _pagamentoCard(context, index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showPagamentoPage();
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Widget _pagamentoCard(BuildContext context, index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/payments.png")
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: ${pagamentos[index].id}" ),
                    Text("Valor: ${pagamentos[index].valor}" ),
                    Text("Data: ${pagamentos[index].data}" ),
                    Text("Forma PG: ${pagamentos[index].formas_pagamento_id}" ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        _showPagamentoPage(pagamento: pagamentos[index]);
      },
    );
  }

  void _getAllPagamentos(){
    pagamentoHelper.getAllPagamento().then((list){
      setState(() {
        pagamentos = list;
      });

    });
  }

  void _showPagamentoPage({Pagamento pagamento}) async{
    final recPagamento = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => PagamentoPage(pagamento: pagamento)
    ));
    if(recPagamento != null ){
      if(pagamento != null){
        await pagamentoHelper.updatePagamento(recPagamento);
      }else{
        await pagamentoHelper.createPagamento(recPagamento);
      }
      _getAllPagamentos();
    }
  }


}
