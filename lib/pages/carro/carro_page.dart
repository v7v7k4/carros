import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();
  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();
    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.place), onPressed: _onClickMapa),
          IconButton(icon: Icon(Icons.videocam), onPressed: _onClickVideo),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopUpMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                )
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
                imageUrl:widget.carro.urlFoto),
            _bloco01(),
            Divider(color: Colors.grey),
            _bloco02(),
          ],
        ));
  }

  _bloco02(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(widget.carro.descricao, fontSize: 16, bold: true),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            return text(snapshot.data, fontSize: 16);
          },
        )

      ],
    );
  }

  Row _bloco01() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text(widget.carro.nome, fontSize: 20, bold: true),
                  text(widget.carro.tipo, fontSize: 18),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.favorite, color: Colors.red, size: 40,), onPressed: _onClickFavorito),
                  IconButton(icon: Icon(Icons.share, size: 40,), onPressed: _onClickShare),
                ],
              )
            ],
          );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopUpMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar !!!");
        break;
      case "Deletar":
        print("Deletar !!!");
        break;
      case "Share":
        print("Share !!!");
        break;
    }
  }

  void _onClickFavorito() {
    FavoritoService.favoritar(carro);
  }

  void _onClickShare() {
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
