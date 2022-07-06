
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

late Refeicao refeicaoDisponivel;

Future buscaRefeicoesAtivas(String nome_usuario,String senha,String estado)async{
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);
  String url = 'https://refeitorio-cacor.herokuapp.com/refeicao/$estado/status';

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
    }
    if(element.status == 'A' && element.horario == horarioJanta.id){
      //Refeicao refeicao = element;
      //print(_dataHoje.hour);
      //print(horarioJanta.inicio_reserva_prioritario.hour);
      //print(horarioJanta.fim_reserva.hour);
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
  if (verificaRefeicaoNula()){
    validador = true;
  }else{
    validador = false;
  }
  ValidadorPrincipal = validador;
  return validador;
}


Refeicao retornaRefeicaoDisponivel(){
  return refeicaoDisponivel;
}
  
bool retornaValidacaoDeRefeicao(){
  return ValidadorPrincipal;
}

bool verificaRefeicaoNula(){
  if(refeicaoDisponivel != null){
    return true;
  }
  return false;
}
/*
bool validaAlmocoPrioridade(){//Valida se o aluno é ou não prioritário nessa refeição, e se ele está no horárioalmoço
  if(retornaValidadoRefeicao() != null && refeicaoDisponivel.horario == horarioDeAlmoco.id && horarioDeAlmoco.turno_prioridade == _alunoLogado.turno){
    return true;
  }else{
    return false;
  }
}

bool validaJantaPrioridade(){//Valida se o aluno é ou não prioritário nessa refeição, e se ele está no horário de janta
  if(retornaValidadoRefeicao() && refeicaoDisponivel.horario == horarioDeJanta.id && horarioDeJanta.turno_prioridade == _alunoLogado.turno){
    return true;
  }else{
    return false;
  }
}

bool validaAlmocoNaoPrioridade(){////Valida se um aluno não é priritário para o almoço
    if(retornaValidadoRefeicao() && refeicaoDisponivel.horario == horarioDeAlmoco.id && horarioDeAlmoco.turno_prioridade != _alunoLogado.turno){
      return true;
    }else{
      return false;
    }
  }

  bool validaJantaNaoPrioridade(){//Valida se um aluno não é priritário para a janta
    if(retornaValidadoRefeicao() && refeicaoDisponivel.horario == horarioDeJanta.id && horarioDeJanta.turno_prioridade != _alunoLogado.turno){
      return true;
    }else{
      return false;
    }
  }

  bool validaHorarioAlmoco(){//Valida se o horário atual está válido para reservar almoço de um aluno não priritário
    if(_horaAtual.hour >= horarioDeAlmoco.inicio_reserva.hour && _horaAtual.hour < horarioDeAlmoco.fim_reserva.hour){
      return true;
    }else{
      return false;
    }
  }

  bool validaHorarioJanta(){//Valida se o horário atual está válido para reservar janta de um aluno não priritário
    if(_horaAtual.hour >= horarioDeJanta.inicio_reserva.hour && _horaAtual.hour < horarioDeJanta.fim_reserva.hour){
      return true;
    }else{
      return false;
    }
  }*/