import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focuSenha = FocusNode();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
        ),
        body: _body());
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        //envolver em um container para poder dar espaço entre os labels, inputs e a tela em si
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText("Login", "Digite o Login", controller: _tLogin,
                validator: _validateLogin,
                textInputAction: TextInputAction.next,
                nextFocus: _focuSenha,
            ),
            SizedBox(
              height: 10,
            ), //espaço entre o ultimo input e o botão
            AppText("Senha", "Digite a senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focuSenha,
            ),
            SizedBox(
              height: 20,
            ), //espaço entre o ultimo input e o botão
            StreamBuilder<bool>(
              stream: _bloc.buttonBloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton("Login", onPressed: _onClickLogin, showProgress: snapshot.data,);
              }
            )
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    String login = _tLogin.text;
    String senha = _tSenha.text;

    bool formOK = _formKey.currentState.validate();
    if (!formOK) return;

    print("login: $login, senha: $senha");



    ApiResponse apiResponse = await _bloc.login(login, senha);

    if(apiResponse.ok){
      Usuario usuario = apiResponse.result;
      print(usuario);
      push(context, HomePage());
    } else {
      alert(context,apiResponse.msg);
    }

  }

  String _validateLogin(String text) {
    if (text.isEmpty) return "Digite o login";
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) return "Digite a senha";
    if (text.length < 3)
      return "A senha precisa ter pelo menos 3 números";
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
