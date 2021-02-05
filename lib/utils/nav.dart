import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}){
  if(replace){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){ //pushReplacement substitui a tela e tira o botão de voltar
      return page;
    }));
  }
  //navegar para a proxima tela
  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){ //push coloca uma tela por cima da outra e o botão de voltar
//      return HelloPage1();
    return page;
  }));
}