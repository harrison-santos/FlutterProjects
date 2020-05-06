import "package:flutter/material.dart";
import "package:projetoclinica/helpers/paciente_helper.dart";

class CadastroPaciente extends StatefulWidget {
  @override
  _CadastroPacienteState createState() => _CadastroPacienteState();
}

class _CadastroPacienteState extends State<CadastroPaciente> {
  PacienteHelper pacienteHelper = PacienteHelper();

  @override
  void initState()  {
    /* CREATE
    Paciente paciente = Paciente();
    paciente.nome = "Werliney";
    paciente.dt_nascimento = "04/06/1997";
    paciente.rg = "0009993333";
    paciente.cpf = "777777777";
    paciente.endereco_id = 1;
    pacienteHelper.createPaciente(paciente);
    */

    pacienteHelper.readPaciente(2).then((p1){
      p1.nome = "Harrison";
      pacienteHelper.updatePaciente(p1).then((p1){
        print(p1);
      });
    });

    //pacienteHelper.deletePaciente(3);

    pacienteHelper.getAllPaciente().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ,
    );
  }


}
