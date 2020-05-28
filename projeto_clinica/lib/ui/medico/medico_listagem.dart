import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:projetoclinica/helpers/medico_helper.dart";
import 'package:projetoclinica/ui/medico/medico_page.dart';


class ListagemMedico extends StatefulWidget {
  @override
  _ListagemMedicoState createState() => _ListagemMedicoState();
}

class _ListagemMedicoState extends State<ListagemMedico> {
  MedicoHelper medicoHelper = MedicoHelper();
  List<Medico> medicos = List();

  @override
  void initState()  {
    super.initState();

    _getAllMedicos();

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
    //medicoHelper.deleteMedico(1);

    medicoHelper.getAllMedico().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de Médicos"),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: medicos.length,
          itemBuilder: (context, index){
            return _medicoCard(context, index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showMedicoPage();
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Widget _medicoCard(BuildContext context, index){
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
                      image: AssetImage("images/doctor.png")
                ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: ${medicos[index].id}" ),
                    Text("Nome: ${medicos[index].nome}" ),
                    Text("Crm: ${medicos[index].crm}" ),
                    Text("Especialidade: ${medicos[index].especialidade_id}" ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
       // _showMedicoPage(medico: medicos[index]);
      },
    );
  }

  void _getAllMedicos(){
    medicoHelper.getAllMedico().then((list){
      setState(() {
        medicos = list;
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
                        _showMedicoPage(medico: medicos[index]);
                      },
                    ),
                    FlatButton(
                      child: Text("Excluir"),
                      onPressed: (){
                        print(medicos[index].id);
                        medicoHelper.deleteMedico(medicos[index].id);
                        setState(() {
                          medicos.removeAt(medicos[index].id);
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

  void _showMedicoPage({Medico medico}) async{
    final recMedico = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => MedicoPage(medico: medico)
    ));
    if(recMedico != null ){
      if(medico != null){
        await medicoHelper.updateMedico(recMedico);
      }else{
        await medicoHelper.createMedico(recMedico);
      }
      _getAllMedicos();
    }
  }


}
