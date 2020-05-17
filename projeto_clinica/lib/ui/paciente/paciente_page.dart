import 'package:flutter/material.dart';
import 'package:projetoclinica/helpers/paciente_helper.dart';


class PacientePage extends StatefulWidget {
  final Paciente paciente;

  PacientePage({this.paciente});//Parametro opcional

  @override
  _PacientePageState createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {

  bool _userEdited = false;
  Paciente _editedPaciente;

  final _nomeController = TextEditingController();
  final _dtNascimentoController = TextEditingController();
  final _rgController = TextEditingController();
  final _cpfController = TextEditingController();
  final _enderecoController = TextEditingController();

  final _nomeFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.paciente == null){
      _editedPaciente = Paciente();
    }else{
      _editedPaciente = Paciente.fromMap(widget.paciente.toMap());
      _nomeController.text = _editedPaciente.nome;
      _dtNascimentoController.text = _editedPaciente.dt_nascimento;
      _rgController.text = _editedPaciente.rg;
      _cpfController.text = _editedPaciente.cpf;
      _enderecoController.text = _editedPaciente.endereco_id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(_editedPaciente.nome ?? "Novo Contato"),
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
                        image: AssetImage("images/patient.png")
                    )
                ),
              ),
            ),
            TextField(
              controller: _nomeController,
              focusNode: _nomeFocus,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedPaciente.nome = text;
                });
              },
            ),
            TextField(
              controller: _dtNascimentoController,
              decoration: InputDecoration(labelText: "Data de Mascimento: "),
              onChanged: (text){
                _userEdited = true;
                _editedPaciente.dt_nascimento = text;
              },
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: "RG: "),
              onChanged: (text){
                _userEdited = true;
                _editedPaciente.rg = text;
              },
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: "CPF: "),
              onChanged: (text){
                _userEdited = true;
                _editedPaciente.cpf = text;
              },
            ),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: "Endereco: "),
              onChanged: (text){
                _userEdited = true;
                _editedPaciente.endereco_id = "1";
              },
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedPaciente.nome != null && _editedPaciente.nome.isNotEmpty ){
            Navigator.pop(context, _editedPaciente);
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
