
import 'dart:convert';
import 'dart:io';

import 'package:app_refeitorio/buscas/busca_user.dart';
import 'package:app_refeitorio/models/refeicao.dart';
import 'package:app_refeitorio/models/reservas.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../autorizacao/autorizacao.dart';
import '../buscas/busa_reservas_aluno.dart';
import '../buscas/busca_refeicao_ativas.dart';

Refeicao refeicao_disponivel = retornaRefeicaoDisponivel();
int quantidade_reservadas = refeicao_disponivel.quantidade_reservadas;

String user_reserva = retorna_user_reserva();
String senha_reserva = retorna_senha_reserva();

String mensagem = '';

DateTime data_reserva = DateTime.now();
bool reserva_feita = false;

var nova_refeicao_disponivel;
var nova_reserva;

Future faz_reserva(int aluno_reserva,int refeicao_reservada)async{

  BasicAuths auth = BasicAuths(usuario: user_reserva, senha: senha_reserva);
  String url = 'https://refeitorio-cacor.herokuapp.com/reservas/';

  var responses;
  try{
    var response = await http.post(Uri.parse(url), 
    headers: <String,String>{'authorization':auth.BasicAuth()},
    body: <String,dynamic>{
      "aluno_reserva":aluno_reserva.toString(),
      "refeicao_reservada":refeicao_reservada.toString(),
      "data_reserva":data_reserva.toString()
    }
    );
    //print(response.statusCode);
    //print(response.body);

    if(response.statusCode == 201){
      mensagem = 'Refeição reservada';

      var data = jsonDecode(response.body);
      nova_reserva = Reservas(
        id: data['id'], 
        data_reserva: DateTime.parse(data['data_reserva']).toLocal(), 
        aluno_reserva: data['aluno_reserva'], 
        refeicao_reservada: data['refeicao_reservada']);

      //limpa_lista_refeicao_disponivel();
      await atualiza_quantidade_refeicoes_reservadas(refeicao_reservada,quantidade_reservadas+1);
      //await buscaRefeicoesAtivas(user_reserva,senha_reserva,'A');
      //await buscaReservasDeUmAluno(user_reserva,senha_reserva,aluno_reserva.toString());
      reserva_feita = true;
    }

  }on ClientException{
    mensagem = 'Erro de conexão';
    reserva_feita = false;
  }on NoSuchMethodError{
    mensagem = 'Erro de conexão';
    reserva_feita = false;
  }on SocketException{
    mensagem = 'Erro de conexão';
    reserva_feita = false;
  } 
}

bool retorna_resultado_reserva(){
  return reserva_feita;
}

String retorna_mensagem_erro_reserva(){
  return mensagem;
}

Future atualiza_quantidade_refeicoes_reservadas(int id_refeicao,int quant_reservadas)async{

  //quant_reservadas++;
  var response;

  String id = id_refeicao.toString();

  BasicAuths auth = BasicAuths(usuario: user_reserva, senha: senha_reserva);
  String url = 'https://refeitorio-cacor.herokuapp.com/refeicao/$id/';

  var result = await http.patch(Uri.parse(url),
    headers: <String,String>{'authorization':auth.BasicAuth()},
    body: <String,dynamic>{
      "quantidade_reservadas":quant_reservadas.toString()
    });

    //print(result.body);
    var data = jsonDecode(result.body);


    nova_refeicao_disponivel  = Refeicao(
      id: data['id'], 
      tipo_da_refeicao: data['tipo_da_refeicao'], 
      cardapio: data['cardapio'], 
      quantidade: data['quantidade'], 
      quantidade_reservadas: data['quantidade_reservadas'], 
      horario: data['horario'], 
      data_oferta: DateTime.parse(data['data_oferta']).toLocal(), 
      status: data['status']);
    
    quantidade_reservadas = nova_refeicao_disponivel.quantidade_reservadas;
}

Refeicao retorna_nova_refeicao_disponivel(){
  if(nova_refeicao_disponivel == null){
    nova_refeicao_disponivel = Refeicao(
      id: refeicao_disponivel.id,
      tipo_da_refeicao: refeicao_disponivel.tipo_da_refeicao, 
      cardapio: refeicao_disponivel.cardapio, 
      quantidade: refeicao_disponivel.quantidade, 
      quantidade_reservadas: refeicao_disponivel.quantidade_reservadas, 
      horario: refeicao_disponivel.horario, 
      data_oferta: refeicao_disponivel.data_oferta, 
      status: refeicao_disponivel.status);  
  }
  return nova_refeicao_disponivel;
}


Reservas retorna_nova_reserva(){
  if (nova_reserva == null){
    nova_reserva = Reservas(
      id: 0, 
      data_reserva: DateTime.now(), 
      aluno_reserva: 0, 
      refeicao_reservada: 0);
  }
  return nova_reserva;
}

Future cancela_reserva(int id_reserva)async{

  String id_da_reserva = id_reserva.toString();
  
  BasicAuths auth = BasicAuths(usuario: user_reserva, senha: senha_reserva);
  String url = 'https://refeitorio-cacor.herokuapp.com/reservas/$id_da_reserva/';
  
  try{

    var response = await http.delete(Uri.parse(url),
    headers: <String,String>{'authorization':auth.BasicAuth()});

    //print(response.statusCode);
    if(response.statusCode == 204){
      await atualiza_quantidade_refeicoes_reservadas(refeicao_disponivel.id,quantidade_reservadas-1);
      mensagem = 'Refeição cancelada!';
      reserva_feita = false;
    }
  }on ClientException{
    mensagem = 'Erro de conexão';
    //reserva_feita = false;
  }on NoSuchMethodError{
    mensagem = 'Erro de conexão';
    //reserva_feita = false;
  }on SocketException{
    mensagem = 'Erro de conexão';
    //reserva_feita = false;
  }
}
