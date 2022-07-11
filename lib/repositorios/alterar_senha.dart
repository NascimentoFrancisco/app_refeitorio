import 'dart:convert';
import 'dart:io';
import 'package:app_refeitorio/buscas/busca_user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../autorizacao/autorizacao.dart';

String nome_usuario = retorna_user_reserva();
String mensagem_troca = '';

bool situacao_alteracao = false;

Future alterar_a_senha(String senha,String senha_nova)async{
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);

  String parametro = senha;
  //print('Início troca senha');
  //
  String url = 'https://refeitorio-cacor.herokuapp.com/alterar-senha/';
  
  try{
    var response = await http.put(Uri.parse(url),
      headers: <String,String>{'authorization':auth.BasicAuth()},
      body: {'old_password': senha,'new_password': senha_nova} 
    );

    //print(response.statusCode);
    //print('Inicio');
    if(response.statusCode == 200){
      //print('Alterou');
      mensagem_troca = 'Senha alterada com sucesso!';
      situacao_alteracao = true;
    }
  
  }on ClientException{
    mensagem_troca='Erro de conexão';
    //reserva_feita = false;
  }on NoSuchMethodError{
    mensagem_troca='Erro de conexão';
    //reserva_feita = false;
  }on SocketException{
    mensagem_troca='Erro de conexão';
    //reserva_feita = false;
  }
}

bool retorna_situacao(){
  return situacao_alteracao;
}

String retorna_mensagem(){
  return mensagem_troca;
}