import 'package:flutter/material.dart';
import 'package:projetoclinica/ui/consulta/consulta_listagem.dart';
import "package:projetoclinica/ui/paciente/paciente_listagem.dart";
import "package:projetoclinica/ui/medico/medico_listagem.dart";
import 'package:projetoclinica/ui/pagamentos/pagamento_listagem.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinica Medica"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListagemMedico())
                );
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage("images/doctor.png")
                        )
                    ),
                  ),
                  Text(
                      "Medicos",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                  ),
                ],
              )
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListagemPaciente()));
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage("images/patients.png")
                          )
                      ),
                    ),
                    Text(
                        "Pacientes",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    ),
                  ],
                )
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListagemConsulta())
                  );
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage("images/exams.png")
                          )
                      ),
                    ),
                    Text(
                        "Consultas",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    ),
                  ],
                )
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListagemPagamento())
                  );
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage("images/payments.png")
                          )
                      ),
                    ),
                    Text(
                        "Pagamentos",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    ),
                  ],
                )
            ),



          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Inicio")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              title: Text("Sair")
          ),
        ],
      ),
    );
  }

}
