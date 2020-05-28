import "package:flutter/material.dart";
import 'package:projetoclinica/helpers/especialidade_helper.dart';
import 'package:projetoclinica/helpers/medico_helper.dart';

class MedicoPage extends StatefulWidget {
  final Medico medico;

  MedicoPage({this.medico});

  @override
  _MedicoPageState createState() => _MedicoPageState();
}

class _MedicoPageState extends State<MedicoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _userEdited = false;
  Medico _editedMedico;
  final _nomeController = TextEditingController();
  final _crmController = TextEditingController();
  final _especialidadeController = TextEditingController();
  EspecialidadeHelper especialidadeHelper = EspecialidadeHelper();
  List<Especialidade> listaEspecialidades = List();
  String dropdownEspecialidades = "";

  @override
  void initState() {
    super.initState();
    _getAllEspecialidades();
    if (widget.medico == null) {
      _editedMedico = Medico();
    } else {
      _editedMedico = Medico.fromMap(widget.medico.toMap());
      _nomeController.text = _editedMedico.nome;
      _crmController.text = _editedMedico.crm;
      //_especialidadeController.text = _editedMedico.especialidade_id.toString();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
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
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedMedico.nome = text;
                  });
                },
              ),
              TextFormField(
                controller: _crmController,
                decoration: InputDecoration(labelText: "Crm"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedMedico.crm = text;
                },
              ),
              /*
            TextField(
              controller: _especialidadeController,
              decoration: InputDecoration(labelText: "Especialidade ID"),
              keyboardType: TextInputType.number,
              onChanged: (text){
                _userEdited = true;
                _editedMedico.especialidade_id = int.parse(text);
              },
            ),*/
              Container(
                child: Row(
                  children: <Widget>[
                    Text("Especialidade: ", style: TextStyle(fontSize: 16)),
                    DropdownButton<String>(
                      value: dropdownEspecialidades,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownEspecialidades = newValue;
                          for (var especialidade in listaEspecialidades){
                            if(especialidade.descricao == newValue){
                              _editedMedico.especialidade_id = especialidade.id;
                            }
                          }
                        });
                      },
                      items: listaEspecialidades.map<DropdownMenuItem<String>>((
                          Especialidade value) {
                        return DropdownMenuItem<String>(
                          value: value.descricao,
                          child: Text(value.descricao),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),

            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_editedMedico.nome.isNotEmpty) {
            Navigator.pop(context, _editedMedico);
          } else {

          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _getAllEspecialidades()  {
    especialidadeHelper.getAllEspecialidade().then((list)  {
      setState(() {
        listaEspecialidades = list;
        if(_editedMedico.especialidade_id == null){
          setState(() {
            dropdownEspecialidades = listaEspecialidades.first.descricao;
            _editedMedico.especialidade_id = listaEspecialidades.first.id;
          });
        }else{
          for (var especialidade in listaEspecialidades){
            if(especialidade.id == _editedMedico.especialidade_id){
              dropdownEspecialidades = especialidade.descricao;
            }
          }

        }
        print(listaEspecialidades);
      });
    });
  }
}
