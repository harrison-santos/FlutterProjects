import "package:flutter/material.dart";
import 'package:projetoclinica/helpers/medico_helper.dart';

class MedicoPage extends StatefulWidget {
  final Medico medico;

  MedicoPage({this.medico});

  @override
  _MedicoPageState createState() => _MedicoPageState();
}

class _MedicoPageState extends State<MedicoPage> {
  bool _userEdited = false;
  Medico _editedMedico;
  final _nomeController = TextEditingController();
  final _crmController = TextEditingController();
  final _especialidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.medico == null){
      _editedMedico = Medico();
    }else{
      _editedMedico = Medico.fromMap(widget.medico.toMap());
      _nomeController.text = _editedMedico.nome;
      _crmController.text = _editedMedico.crm;
      _especialidadeController.text = _editedMedico.especialidade_id.toString();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedMedico.nome ?? "Novo Medico"),
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
                        image: AssetImage("images/doctor.png")
                    ),
                  )
              ),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedMedico.nome = text;
                });
              },
            ),
            TextField(
              controller: _crmController,
              decoration: InputDecoration(labelText: "Crm"),
              onChanged: (text){
                _userEdited = true;
                _editedMedico.crm = text;
              },
            ),
            TextField(
              controller: _especialidadeController,
              decoration: InputDecoration(labelText: "Especialidade ID"),
              keyboardType: TextInputType.number,
              onChanged: (text){
                _userEdited = true;
                _editedMedico.especialidade_id = int.parse(text);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedMedico.nome.isNotEmpty){
            Navigator.pop(context, _editedMedico);
          }else{

          }
        },
        child: Icon(Icons.save),
      ),
    );
  }


}
