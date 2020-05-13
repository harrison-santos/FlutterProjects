import 'dart:io';
import "package:flutter/material.dart";

class ListagemPagamento extends StatefulWidget {
  @override
  _ListagemPagamentoState createState() => _ListagemPagamentoState();
}

class _ListagemPagamentoState extends State<ListagemPagamento> {
  @override
  void initState()  {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de Pagamentos"),
      ),
    );
  }

  
}
