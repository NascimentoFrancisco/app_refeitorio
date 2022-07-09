
import 'package:app_refeitorio/buscas/busca_horarios.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/horarios.dart';
import 'package:app_refeitorio/models/refeicao.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../autorizacao/autorizacao.dart';
import 'busca_aluno_pelo_user.dart';

List<Refeicao> ListRefeicoes = [];
List<Horarios> ListaHorarios = retornaListaHorarios();

Horarios horarioAlmoco = retornaHorarioAlomco();
Horarios horarioJanta = retornaHorarioJanta();

DateTime _dataHoje = DateTime.now();

bool ValidadorPrincipal= false;

Aluno _alunoLogado =  retornaAluno();

Horarios horarioDeAlmoco = retornaHorarioAlomco();
Horarios horarioDeJanta = retornaHorarioJanta();

DateTime _horaAtual = DateTime.now();

//late Refeicao refeicaoDisponivel;
var refeicaoDisponivel;//?

Future buscaRefeicoesAtivas(String nome_usuario,String senha,String estado)async{
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);
  String url = 'https://refeitorio-cacor.herokuapp.com/refeicao/$estado/status';

  print('buscando rfeições ativas');
  var response = await http.get(Uri.parse(url), 
  headers: <String,String>{'authorization':auth.BasicAuth()});
  
  //print(response.statusCode);
  //print(response.body);
  List<dynamic> data = jsonDecode(response.body);

  data.forEach((element) { 
    Refeicao refeicao = Refeicao(
      id: element['id'], 
      tipo_da_refeicao: element['tipo_da_refeicao'], 
      cardapio: element['cardapio'], 
      quantidade: element['quantidade'], 
      quantidade_reservadas: element['quantidade_reservadas'], 
      horario: element['horario'], 
      data_oferta: DateTime.parse(element['data_oferta']).toLocal(),  
      status: element['status']);

      ListRefeicoes.add(refeicao);
  });
}


List<Refeicao> retornaListRefeicao(){
  return ListRefeicoes;
}

bool retornaValidadoRefeicao(){
  bool validador = false;
  int cont = 0;
  ListRefeicoes.forEach((element) { 
    if(element.status == 'A' && element.horario == horarioAlmoco.id){
      //Refeicao refeicao = element;
      if(_dataHoje.hour >= horarioAlmoco.inicio_reserva_prioritario.hour && _dataHoje.hour < horarioAlmoco.fim_reserva.hour){
        validador = true;
        refeicaoDisponivel = Refeicao(
          id: element.id, 
          tipo_da_refeicao: element.tipo_da_refeicao, 
          cardapio: element.cardapio, 
          quantidade: element.quantidade, 
          quantidade_reservadas: element.quantidade_reservadas, 
          horario: element.horario, 
          data_oferta: element.data_oferta, 
          status: element.status);
      }
    }else if(element.status == 'A' && element.horario == horarioJanta.id){
      if(_dataHoje.hour >= horarioJanta.inicio_reserva_prioritario.hour && _dataHoje.hour < horarioJanta.fim_reserva.hour){
        validador = true;
        refeicaoDisponivel = Refeicao(
          id: element.id, 
          tipo_da_refeicao: element.tipo_da_refeicao, 
          cardapio: element.cardapio, 
          quantidade: element.quantidade, 
          quantidade_reservadas: element.quantidade_reservadas, 
          horario: element.horario, 
          data_oferta: element.data_oferta, 
          status: element.status);
      }
    }
  });
  
  ValidadorPrincipal = validador;
  return validador;
}

Refeicao retornaRefeicaoDisponivel(){
  if(refeicaoDisponivel==null){
    refeicaoDisponivel = Refeicao(id: 0, tipo_da_refeicao: 'M', cardapio: '', quantidade: 0, quantidade_reservadas: 0, horario: 0, data_oferta: _dataHoje, status: 'D');
  }
  return refeicaoDisponivel;
}
  
bool retornaValidacaoDeRefeicao(){
  return ValidadorPrincipal;
}

//LateError (LateInitializationError: Field 'refeicaoDisponivel' has not been initialized.)
/*bool verificaRefeicaoNula(){
  if(refeicaoDisponivel == null){
    return true;
  }
  return false;
}*/
