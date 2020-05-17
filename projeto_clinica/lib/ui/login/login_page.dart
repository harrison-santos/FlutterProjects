
import 'package:flutter/material.dart';
import 'package:projetoclinica/helpers/user_helper.dart';
import 'package:projetoclinica/ui/home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserHelper userHelper = UserHelper();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Clínica Azumba"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/hospital.png")
                      )
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "Usuario"),
                  validator: (value){
                    if (value.isEmpty){
                      return "Insira o nome de usu[ario";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Senha"),
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira a senha";
                    }
                    return null;
                  },
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async{
                          print(_usernameController.text);
                          print(_passwordController.text);
                          /*User user1 = User("admin", "admin");
                        var admin = await userHelper.createUser(user1);*/
                          var user =  await userHelper.getLogin(_usernameController.text, _passwordController.text);

                          if (user != null){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                            //print("Usu[ario existe");
                          }else{
                            final snackbar = SnackBar(
                              content: Text("Usuário ou senha incorretos!"),
                              action: SnackBarAction(
                                label: "Fechar",
                                onPressed: (){},
                              ),
                            );

                            _scaffoldKey.currentState.showSnackBar(snackbar);

                            //print("Usu[ario nao existe");
                          }

                          /*
                    if(_formKey.currentState.validate()){
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Aguarde um momento...")));
                    }*/
                        },
                        child: Text("Enviar"),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      )
    );
  }
}
