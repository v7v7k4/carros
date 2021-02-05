import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi{
  static Future<List<Carro>> getCarros(String tipo) async{

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    Usuario usuario = await Usuario.get();
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;
    print(json);

    List list = convert.json.decode(json); //{} é um map, colchetes é uma lista

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();




    return carros;
  }
}