import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/network.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>>{


  Future<List<Carro>> fetch() async{
    try {
      bool networkOn = await isNetworkOn();

      List<Carro> cs = await FavoritoService.getCarros();

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