import "package:flutter/material.dart";
import "package:projetoclinica/helpers/especialidade_helper.dart";

class CadastroEspecialidade extends StatefulWidget {
  @override
  _CadastroEspecialidadeState createState() => _CadastroEspecialidadeState();
}

class _CadastroEspecialidadeState extends State<CadastroEspecialidade> {
  EspecialidadeHelper especialidadeHelper = EspecialidadeHelper();

  @override
  void initState()  {
    /* CREATE
    Especialidade especialidade = Especialidade();
    especialidade.descricao = "Dermatologista";
    especialidadeHelper.createEspecialidade(especialidade);
    */

    /*
    especialidadeHelper.readEspecialidade(1).then((p1){
      p1.descricao = "Dentista";
      especialidadeHelper.updateEspecialidade(p1).then((p1){
        print(p1);
      });
    });*/

    //especialidadeHelper.deleteEspecialidade(3);

    especialidadeHelper.getAllEspecialidade().then((list){
      print(list);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
