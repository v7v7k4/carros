import 'package:carros/pages/carro/home_page.dart';
import 'file:///C:/Users/vivil/OneDrive/Documents/workspace-vivs-flutter/carros/lib/utils/sql/db_helper.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    /*Future.delayed(Duration(seconds: 15), () {
      push(context, LoginPage());
    });*/

    //Inicializar o banco de dados
    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 15));

    //usuario
    Future<Usuario> futureC = Usuario.get(); //para mostrar na tela de login o ultimo usuario logado
    /*future.then((Usuario usuario) {
      if(usuario != null){ //verifica se existe o usuário e se existir entra direto na home
        /*setState((){ //redesenha a tela
         _tLogin.text = usuario.login;
       });*/
        push(context, HomePage(), replace: true);
      }
    });*/
    
    Future.wait([futureA, futureB, futureC]).then((List values) {
      print(values);
      Usuario usuario = values[2];
      print(usuario);
      if(usuario != null){
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
