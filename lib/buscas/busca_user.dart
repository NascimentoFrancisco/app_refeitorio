import 'dart:io';

import 'package:app_refeitorio/autorizacao/autorizacao.dart';
import 'package:app_refeitorio/buscas/busa_reservas_aluno.dart';
import 'package:app_refeitorio/buscas/busca_horarios.dart';
import 'package:app_refeitorio/buscas/busca_refeicao_ativas.dart';
import 'package:app_refeitorio/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'busca_aluno_pelo_user.dart';

late User _user;
bool erro_conexao = false;
String mensagem_erro = '';

String user_reserva = '';
String senha_reserva = '';


Future buscarUser(String nome_usuario, String senha)async{
  
  if(nome_usuario.isEmpty || senha.isEmpty){
    mensagem_erro = 'Dados não inseridos';
    return false;
  }

  BasicAuths basicAuth = BasicAuths(usuario: nome_usuario, senha: senha);
  user_reserva = nome_usuario;
  senha_reserva = senha;
  var response;
  try{
    String url = 'https://refeitorio-cacor.herokuapp.com/user/$nome_usuario/usuario';
    response = await http.get(Uri.parse(url),
    headers: <String,String>{'authorization':basicAuth.BasicAuth()});

    //print(response.statusCode);
    //print(response.body);
  }on ClientException{
    mensagem_erro = 'Erro de conexão';
  }on SocketException{
    mensagem_erro = 'Erro de conexão';
  }
  //List<dynamic> data = jsonDecode(response.body);  
  //var user = data[0]; 
  try{
    if (response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);  
      var user = data[0]; 
    
      await buscaAlunoPeluUser(nome_usuario,senha,user['id'].toString());
      _user = User(id: user['id'], username: user['username'], email: user['email']);
      await buscaHorarios(nome_usuario, senha);
      await buscaRefeicoesAtivas(nome_usuario, senha, 'A');
      mensagem_erro = '';
      return true;
    
    }else if(response.statusCode == 401){
      print('erro 401');
      mensagem_erro = 'CPF ou senha incorreto!';
      return false;
    }else{
      return false;
    }
  }on ClientException{
    mensagem_erro = 'Erro de conexão';
  }on NoSuchMethodError{
    //erro_conexao = true;
    mensagem_erro = 'Erro de conexão';
    return false;
  }on SocketException{
    //erro_conexao = true;
    mensagem_erro = 'Erro de conexão';
    return false;
  }
  //return response;
}

User retornaUsuario(){
  return _user;
}

String retorna_mensagem_erro(){
  return mensagem_erro;
}

String retorna_user_reserva(){
  return user_reserva;
}

String retorna_senha_reserva(){
  return senha_reserva;
}
