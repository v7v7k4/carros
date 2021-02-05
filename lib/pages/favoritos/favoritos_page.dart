import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'favoritos_bloc.dart';

class FavoritosPage extends StatefulWidget {
  String tipo;

  FavoritosPage();

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro> carros;

  final _bloc = FavoritosBloc();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Vantagem do StreamBuilder é que só o meio dele é redesenhado, não é redesenhado o método build inteiro
    return StreamBuilder(
      //return FutureBuilder( //é um widget que fica aguardando o future retornar dai mostra o widget que vc quer
      stream: _bloc.stream, //escutando
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
          return TextError("Não foi possível buscar os favoritos.");
        }
        if(!snapshot.hasData){
          return  Center(child: CircularProgressIndicator(),);
        }
        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }
  @override
  void initState(){ // o método state é chamado apenas uma vez na inicialização do StatefulWidget
    super.initState();
    _bloc.fetch();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

 @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

 Future<void> _onRefresh() {
    return _bloc.fetch();
  }
}
