import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/utils/network.dart';

import 'carros_api.dart';

//logica de negocio da tela de carros
class CarrosBloc extends SimpleBloc<List<Carro>>{


  Future<List<Carro>> fetch(String tipo) async{
    try {
      bool networkOn = await isNetworkOn();
      if(!networkOn){
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> cs = await CarrosApi.getCarros(tipo);

      if(cs.isNotEmpty) {
        final dao = CarroDAO();
        cs.forEach(dao.save); //igual a isso: carros.forEach((element) => dao.save(element));
      }
      //incluir a lista
      add(cs);
      return cs;
    } on Exception catch (e) {
      addError(e);
    }
  }

}