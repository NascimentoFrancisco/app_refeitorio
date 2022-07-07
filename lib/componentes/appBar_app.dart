

import 'package:app_refeitorio/componentes/sobre.dart';
import 'package:app_refeitorio/pages/dados_cadstrais.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../buscas/busca_horarios.dart';
import '../pages/alterar_senha.dart';
import '../pages/loginpage.dart';

class AppBarApp extends StatefulWidget {
  const AppBarApp({Key? key}) : super(key: key);

  @override
  State<AppBarApp> createState() => _AppBarAppState();
}

class _AppBarAppState extends State<AppBarApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Francisco'),
              backgroundColor: Color.fromARGB(255, 6, 168, 90),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_sharp),
              title: Text('Dados cadastrais'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => DadosCadastrais()))
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.key),
              title: Text('Alterar senha'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AlterarSenha()))
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_sharp),
              title: Text('Sobre'),
              onTap: () {
                MostrarSobre(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                limpa_lista_horarios();
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              },
            )
          ],
        ),
      ),
    );
  }
}