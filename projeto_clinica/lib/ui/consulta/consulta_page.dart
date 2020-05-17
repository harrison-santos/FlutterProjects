import "package:flutter/material.dart";
import 'package:projetoclinica/helpers/consulta_helper.dart';

class ConsultaPage extends StatefulWidget {
  final Consulta consulta;

  ConsultaPage({this.consulta});

  @override
  _ConsultaPageState createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  bool _userEdited = false;
  Consulta _editedConsulta;
  final _coberturaController = TextEditingController();
  final _pacienteController = TextEditingController();
  final _medicoController = TextEditingController();
  final _dataController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.consulta == null){
      _editedConsulta = Consulta();
    }else{
      _editedConsulta = Consulta.fromMap(widget.consulta.toMap());
      _coberturaController.text = _editedConsulta.cobertura_id.toString();
      _pacienteController.text = _editedConsulta.paciente_id.toString();
      _medicoController.text = _editedConsulta.medico_id.toString();
      _dataController.text = _editedConsulta.data;

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedConsulta.id != null ? "Consulta numero ${_editedConsulta.id.toString()}" : "Nova Consulta"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child:  Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/exams.png")
                    ),
                  )
              ),
            ),
            TextField(
              controller: _pacienteController,
              decoration: InputDecoration(labelText: "Paciente"),
              keyboardType: TextInputType.number,
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedConsulta.paciente_id = int.parse(text);
                });
              },
            ),
            TextField(
              controller: _medicoController,
              decoration: InputDecoration(labelText: "Médico"),
              keyboardType: TextInputType.number,
              onChanged: (text){
                _userEdited = true;
                _editedConsulta.medico_id = int.parse(text);
              },
            ),
            TextField(
              controller: _coberturaController,
              decoration: InputDecoration(labelText: "Especialidade ID"),
              keyboardType: TextInputType.number,
              onChanged: (text){
                _userEdited = true;
                _editedConsulta.cobertura_id = int.parse(text);
              },
            ),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: "Data"),
              keyboardType: TextInputType.datetime,
              onChanged: (text){
                _userEdited = true;
                _editedConsulta.data = text;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedConsulta.paciente_id != null){
            Navigator.pop(context, _editedConsulta);
          }else{

          }
        },
        child: Icon(Icons.save),
      ),
    );
  }


}
