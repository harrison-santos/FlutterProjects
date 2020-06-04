import "package:flutter/material.dart";
import "package:projetoclinica/helpers/cobertura_helper.dart";

class CadastroCobertura extends StatefulWidget {
  @override
  _CadastroCoberturaState createState() => _CadastroCoberturaState();
}

class _CadastroCoberturaState extends State<CadastroCobertura> {
  CoberturaHelper coberturaHelper = CoberturaHelper();

  @override
  void initState()  {
    /*
    Cobertura cobertura = Cobertura();
    cobertura.descricao = "Golden Edition";
    coberturaHelper.createCobertura(cobertura);
    */
    /*
    coberturaHelper.readCobertura(1).then((p1){
      p1.descricao = "Seu plano tem cobertura";
      coberturaHelper.updateCobertura(p1).then((p1){
        print(p1);
      });
    });*/

    //coberturaHelper.deleteCobertura(3);

    coberturaHelper.getAllCobertura().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
