import "package:flutter/material.dart";
import "package:projetoclinica/helpers/medico_helper.dart";

class CadastroMedico extends StatefulWidget {
  @override
  _CadastroMedicoState createState() => _CadastroMedicoState();
}

class _CadastroMedicoState extends State<CadastroMedico> {
  MedicoHelper medicoHelper = MedicoHelper();

  @override
  void initState()  {
    /*
    Medico medico = Medico();
    medico.nome = "Doutor ney";
    medico.crm = "1234567";
    medico.especialidade_id = 1;
    medicoHelper.createMedico(medico);
    */

    /*
    medicoHelper.readMedico(1).then((p1){
      p1.nome = "Harrison";
      medicoHelper.updateMedico(p1).then((p1){
        print(p1);
      });
    });
    */
    //medicoHelper.deleteMedico(3);

    medicoHelper.getAllMedico().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
