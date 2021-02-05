import 'file:///C:/Users/vivil/OneDrive/Documents/workspace-vivs-flutter/carros/lib/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                //recuperar o usuário
                Usuario usuario = snapshot.data;

                return usuario != null ? _header(usuario) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario usuario) {
    return UserAccountsDrawerHeader(
            accountName: Text(usuario.nome),
            accountEmail: Text(usuario.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  usuario.urlFoto),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear(); //apagar o login do usuário do prefs
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}