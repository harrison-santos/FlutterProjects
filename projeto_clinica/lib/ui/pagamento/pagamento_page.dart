import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoclinica/helpers/pagamento_helper.dart';


class PagamentoPage extends StatefulWidget {
  final Pagamento pagamento;

  PagamentoPage({this.pagamento});//Parametro opcional

  @override
  _PagamentoPageState createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {

  bool _userEdited = false;
  Pagamento _editedPagamento;

  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  final _formas_pagamento_idController = TextEditingController();

  final _nomeFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.pagamento == null){
      _editedPagamento = Pagamento();
    }else{
      _editedPagamento = Pagamento.fromMap(widget.pagamento.toMap());
      _valorController.text = _editedPagamento.valor.toString();
      _dataController.text = _editedPagamento.data;
      _formas_pagamento_idController.text = _editedPagamento.formas_pagamento_id.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(_editedPagamento.id != null ? "Pagamento numero ${_editedPagamento.id.toString()}" : "Novo Pagamento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 130.0,
                height: 130.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/payments.png")
                    )
                ),
              ),
            ),
            TextField(
              controller: _valorController,
              focusNode: _nomeFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Valor"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedPagamento.valor = double.parse(text);
                });
              },
            ),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: "Data"),
              onChanged: (text){
                _userEdited = true;
                _editedPagamento.data = text;
              },
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _formas_pagamento_idController,
              decoration: InputDecoration(labelText: "Forma Pagamento"),
              onChanged: (text){
                _userEdited = true;
                _editedPagamento.formas_pagamento_id = int.parse(text);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedPagamento.valor != null){
            Navigator.pop(context, _editedPagamento);
          }else{
            FocusScope.of(context).requestFocus(_nomeFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }


}
