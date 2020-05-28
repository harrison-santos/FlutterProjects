import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:projetoclinica/helpers/consulta_helper.dart";
import 'package:projetoclinica/ui/consulta/consulta_page.dart';


class ListagemConsulta extends StatefulWidget {
  @override
  _ListagemConsultaState createState() => _ListagemConsultaState();
}

class _ListagemConsultaState extends State<ListagemConsulta> {
  ConsultaHelper consultaHelper = ConsultaHelper();
  List<Consulta> consultas = List();



  @override
  void initState()  {
    super.initState();

    _getAllConsultas();

    /*
    Consulta consulta = Consulta();
    consulta.nome = "Doutor ney";
    consulta.crm = "1234567";
    consulta.especialidade_id = 1;
    consultaHelper.createConsulta(consulta);
     */


    /*
    consultaHelper.readConsulta(1).then((p1){
      p1.nome = "Harrison";
      consultaHelper.updateConsulta(p1).then((p1){
        print(p1);
      });
    });
    */
    //consultaHelper.deleteConsulta(1);

    consultaHelper.getAllConsulta().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de Consultas"),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: consultas.length,
          itemBuilder: (context, index){
            return _consultaCard(context, index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showConsultaPage();
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Widget _consultaCard(BuildContext context, index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/exams.png")
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: ${consultas[index].id}" ),
                    Text("Paciente: ${consultas[index].paciente_id}" ),
                    Text("Medico: ${consultas[index].medico_id}" ),
                    Text("Cobertura: ${consultas[index].cobertura_id}" ),
                    Text("Data: ${consultas[index].data}" ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
        /*_showConsultaPage(consulta: consultas[index]);*/
      },
    );
  }

  void _getAllConsultas(){
    consultaHelper.getAllConsulta().then((list){
      setState(() {
        consultas = list;
      });

    });
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Editar"),
                      onPressed: (){
                        Navigator.pop(context);
                        _showConsultaPage(consulta: consultas[index]);
                      },
                    ),
                    FlatButton(
                      child: Text("Excluir"),
                      onPressed: (){
                        print(consultas[index].id);
                        consultaHelper.deleteConsulta(consultas[index].id);
                        setState(() {
                          consultas.removeAt(consultas[index].id);
                          Navigator.pop(context);
                        });
                      },
                    )

                  ],
                ),
              );
            },
          );
        }
    );

  }

  void _showConsultaPage({Consulta consulta}) async{
    final recConsulta = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => ConsultaPage(consulta: consulta)
    ));
    if(recConsulta != null ){
      if(consulta != null){
        await consultaHelper.updateConsulta(recConsulta);
      }else{
        await consultaHelper.createConsulta(recConsulta);
      }
      _getAllConsultas();
    }
  }


}
