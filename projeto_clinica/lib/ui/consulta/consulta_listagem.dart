import "package:flutter/material.dart";
import "package:projetoclinica/helpers/consulta_helper.dart";

class ListagemConsulta extends StatefulWidget {
  @override
  _ListagemConsultaState createState() => _ListagemConsultaState();
}

class _ListagemConsultaState extends State<ListagemConsulta> {
  ConsultaHelper consultaHelper = ConsultaHelper();

  @override
  void initState()  {
    /*
    Consulta consulta = Consulta();
    consulta.data = "04/05/2022";
    consulta.cobertura_id = 1;
    consulta.medico_id = 1;
    consulta.paciente_id = 1;
    consultaHelper.createConsulta(consulta);
    */
    /*
    consultaHelper.readConsulta(1).then((p1){
      p1.data = "04/05/2030";
      consultaHelper.updateConsulta(p1).then((p1){
        print(p1);
      });
    });*/

    //consultaHelper.deleteConsulta(3);

    consultaHelper.getAllConsulta().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de Consultas"),
      ),
    );
  }


}
