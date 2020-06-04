import "package:flutter/material.dart";
import 'package:projetoclinica/helpers/cobertura_helper.dart';
import 'package:projetoclinica/helpers/consulta_helper.dart';
import 'package:projetoclinica/helpers/medico_helper.dart';
import 'package:projetoclinica/helpers/paciente_helper.dart';

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

  PacienteHelper pacienteHelper = PacienteHelper();
  List<Paciente> listaPacientes = List();
  String dropdownPacientes = "";

  MedicoHelper medicoHelper = MedicoHelper();
  List<Medico> listaMedicos = List();
  String dropdownMedicos = "";

  CoberturaHelper coberturaHelper = CoberturaHelper();
  List<Cobertura> listaCoberturas = List();
  String dropdownCoberturas = "";

  @override
  void initState() {
    super.initState();
    _getAllPacientes();
    _getAllMedicos();
    _getAllCobertura();
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
            Container(
              child: Row(
                children: <Widget>[
                  Text("Paciente: ", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: dropdownPacientes,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownPacientes = newValue;
                        for (var paciente in listaPacientes){
                          if(paciente.nome == newValue){
                            _editedConsulta.paciente_id = paciente.id;
                          }
                        }
                      });
                    },
                    items: listaPacientes.map<DropdownMenuItem<String>>((
                        Paciente value) {
                      return DropdownMenuItem<String>(
                        value: value.nome,
                        child: Text(value.nome),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text("Médico: ", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: dropdownMedicos,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownMedicos = newValue;
                        for (var medico in listaMedicos){
                          if(medico.nome == newValue){
                            _editedConsulta.medico_id = medico.id;
                          }
                        }
                      });
                    },
                    items: listaMedicos.map<DropdownMenuItem<String>>((
                        Medico value) {
                      return DropdownMenuItem<String>(
                        value: value.nome,
                        child: Text(value.nome),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text("Cobertura: ", style: TextStyle(fontSize: 16)),
                  DropdownButton(
                    value: dropdownCoberturas,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    onChanged: (String newValue){
                      setState(() {
                        dropdownCoberturas = newValue;
                        for(var cobertura in listaCoberturas){
                          if(cobertura.descricao == newValue){
                            _editedConsulta.cobertura_id = cobertura.id;
                          }
                        }
                      });
                    },
                    items: listaCoberturas.map<DropdownMenuItem<String>>((Cobertura cobertura){
                      return DropdownMenuItem<String>(
                        value: cobertura.descricao,
                        child: Text(cobertura.descricao),
                      );
                    }).toList(),
                  )

                ],
              ),
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

  void _getAllPacientes(){
      pacienteHelper.getAllPaciente().then((list){
        setState(() {
          listaPacientes = list;
          if (_editedConsulta == null){
            setState(() {
              dropdownPacientes = listaPacientes.first.nome;
              _editedConsulta.paciente_id = listaPacientes.first.id;
            });
          }else{
            for (var paciente in listaPacientes){
              if(paciente.id == _editedConsulta.paciente_id){
                dropdownPacientes = paciente.nome;
              }
            }

          }
        });
      });
  }

  void _getAllMedicos()  {
    medicoHelper.getAllMedico().then((list)  {
      setState(() {
        listaMedicos = list;
        if(_editedConsulta.medico_id == null){
          setState(() {
            dropdownMedicos = listaMedicos.first.nome;
            _editedConsulta.medico_id = listaMedicos.first.id;
          });
        }else{
          for (var medico in listaMedicos){
            if(medico.id == _editedConsulta.medico_id){
              dropdownMedicos = medico.nome;
            }
          }

        }
        print(listaMedicos);
      });
    });
  }

  void _getAllCobertura(){
    coberturaHelper.getAllCobertura().then((list){
      setState(() {
        listaCoberturas = list;
        if(_editedConsulta.cobertura_id == null){
          setState(() {
            dropdownCoberturas = listaCoberturas.first.descricao;
            _editedConsulta.cobertura_id = listaCoberturas.first.id;
          });
        }else{
          for(var cobertura in listaCoberturas){
            if(cobertura.id == _editedConsulta.cobertura_id){
              dropdownCoberturas = cobertura.descricao;
            }
          }
        }
      });
    });

  }
}
