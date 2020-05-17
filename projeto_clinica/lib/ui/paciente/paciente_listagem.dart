import 'dart:io';

import "package:flutter/material.dart";
import "package:projetoclinica/helpers/paciente_helper.dart";

import 'paciente_page.dart';

class ListagemPaciente extends StatefulWidget {
  @override
  _ListagemPacienteState createState() => _ListagemPacienteState();
}

class _ListagemPacienteState extends State<ListagemPaciente> {
  PacienteHelper pacienteHelper = PacienteHelper();
  List<Paciente> pacientes = List();


  @override
  void initState()  {
    super.initState();

    _getAllPaciente();


    /* CREATE
    Paciente paciente = Paciente();
    paciente.nome = "Werliney";
    paciente.dt_nascimento = "04/06/1997";
    paciente.rg = "0009993333";
    paciente.cpf = "777777777";
    paciente.endereco_id = 1;
    pacienteHelper.createPaciente(paciente);
    */
    /*
    pacienteHelper.readPaciente(2).then((p1){
      p1.nome = "Harrison";
      pacienteHelper.updatePaciente(p1).then((p1){
        print(p1);
      });
    });
    */
    //pacienteHelper.deletePaciente(3);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton  (
        onPressed: (){
          _showPacientePage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      appBar: AppBar(
        title: Text("Listagem de Pacientes"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: pacientes.length,
          itemBuilder: (context, index){
            return _pacienteCard(context, index);
          }
      ),
    );
  }


  Widget _pacienteCard(BuildContext context, index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              //Container de Foto
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/patient.png")
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: ${pacientes[index].id}"),
                    Text("Nome: ${pacientes[index].nome ?? ""}"),
                    Text("Nascimento: ${pacientes[index].dt_nascimento}"),
                    Text("RG: ${pacientes[index].rg}"),
                    Text("CPF: ${pacientes[index].cpf}"),
                    Text("Endereco: ${pacientes[index].endereco_id.toString()}")
                  ],
                ),
              ),

            ],
          )
        ),
      ),
      onTap: (){
        _showPacientePage(paciente: pacientes[index]);
      },
    );
  }

  void _showPacientePage({Paciente paciente}) async{
    final recPaciente = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => PacientePage(paciente: paciente))
    );
    if (recPaciente != null){
      if(paciente != null){
        print(paciente);
        await pacienteHelper.updatePaciente(recPaciente);
      }else{
        await pacienteHelper.createPaciente(recPaciente);
      }
      await _getAllPaciente();
    }
  }

  void _getAllPaciente(){
    pacienteHelper.getAllPaciente().then((list){
      setState(() {
        pacientes = list;
      });
    });
  }
}
