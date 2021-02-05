import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;
class LoginApi{
  static Future<ApiResponse<Usuario>> login(String login, String senha) async{
   try{
     var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

     Map<String,String> headers = {
       "Content-Type": "application/json"
     };

     Map params = {
       "username":login,
       "password":senha
     };

     String s = json.encode(params);

     var response = await http.post(url, body: s, headers: headers);
     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');

     Map mapResponse = json.decode(response.body); //recebe a string no formato json e retorna um map

     if(response.statusCode == 200){
       final usuario = new Usuario.fromJson(mapResponse);
       
       usuario.save();


       return ApiResponse.ok(usuario);
     }

     return ApiResponse.error(mapResponse["error"]);
   } catch(error, exception){
     print("Erro no login $error > $exception");
     return ApiResponse.error("Não foi possível fazer o login");
   }

  }
}