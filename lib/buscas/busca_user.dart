import 'package:app_refeitorio/autorizacao/autorizacao.dart';
import 'package:app_refeitorio/buscas/busa_reservas_aluno.dart';
import 'package:app_refeitorio/buscas/busca_horarios.dart';
import 'package:app_refeitorio/buscas/busca_refeicao_ativas.dart';
import 'package:app_refeitorio/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'busca_aluno_pelo_user.dart';

late User _user;


Future buscarUser(String nome_usuario, String senha)async{
  
  if(nome_usuario.isEmpty || senha.isEmpty){
    return false;
  }

  BasicAuths basicAuth = BasicAuths(usuario: nome_usuario, senha: senha);

  String url = 'https://refeitorio-cacor.herokuapp.com/user/$nome_usuario/usuario';
  var response = await http.get(Uri.parse(url),
  headers: <String,String>{'authorization':basicAuth.BasicAuth()});

  print(response.statusCode);
  print(response.body);

  //List<dynamic> data = jsonDecode(response.body);  
  //var user = data[0]; 

  if (response.statusCode == 200){
    List<dynamic> data = jsonDecode(response.body);  
    var user = data[0]; 

    await buscaAlunoPeluUser(nome_usuario,senha,user['id'].toString());
    _user = User(id: user['id'], username: user['username'], email: user['email']);
    await buscaHorarios(nome_usuario, senha);
    await buscaRefeicoesAtivas(nome_usuario, senha, 'A');
    return true;
  }else if(response.statusCode == 401){
    return false;
  }else{
    return false;
  }
  //return response;
}

User retornaUsuario(){
  return _user;
}

