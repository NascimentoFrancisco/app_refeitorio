
import 'dart:convert';
import 'dart:io';

import 'package:app_refeitorio/buscas/busca_user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../autorizacao/autorizacao.dart';

String user_reserva = retorna_user_reserva();
String senha_reserva = retorna_senha_reserva();

String mensagem = '';

DateTime data_reserva = DateTime.now();

Future faz_reserva(int aluno_reserva,int refeicao_reservada)async{

  BasicAuths auth = BasicAuths(usuario: user_reserva, senha: senha_reserva);
  String url = 'https://refeitorio-cacor.herokuapp.com/reservas/';

  var response;
  try{
    response = await http.post(Uri.parse(url), 
    headers: <String,String>{'authorization':auth.BasicAuth()},
    body: jsonEncode(<String,dynamic>{
      "aluno_reserva":aluno_reserva,
      "refeicao_reservada":refeicao_reservada,
      "data_reserva":data_reserva
    }
    ));

    if(response.hashCode == 200){
      mensagem = 'Refeição reservada';
    }

  }on ClientException{
    mensagem = 'Erro de conexão';
  }on NoSuchMethodError{
    mensagem = 'Erro de conexão';
  }on SocketException{
    mensagem = 'Erro de conexão';
  }
  
  

}