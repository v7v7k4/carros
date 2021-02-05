import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/login/usuario.dart';

import 'login_api.dart';

class LoginBloc{

  final buttonBloc = BooleanBloc();

  Future<ApiResponse<Usuario>> login(String login, String senha) async{

    buttonBloc.add(true);

    ApiResponse apiResponse = await LoginApi.login(login, senha);

    buttonBloc.add(false);
    return apiResponse;
  }

  void dispose(){
    buttonBloc.dispose();
  }

}

