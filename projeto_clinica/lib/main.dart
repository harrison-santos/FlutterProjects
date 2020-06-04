import "package:flutter/material.dart";
import 'package:projetoclinica/ui/cobertura/cadastro_cobertura.dart';
import 'package:projetoclinica/ui/home/home_page.dart';
import 'package:projetoclinica/ui/login/login_page.dart';
import 'package:projetoclinica/ui/medico/medico_listagem.dart';
import 'package:projetoclinica/ui/medico/medico_page.dart';
import "package:projetoclinica/ui/paciente/paciente_listagem.dart";
import "package:projetoclinica/ui/paciente/paciente_page.dart";
import 'package:projetoclinica/ui/especialidade/cadastro_especialidade.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));


}