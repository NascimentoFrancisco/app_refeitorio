

import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/buscas/busca_horarios.dart';
import 'package:app_refeitorio/componentes/refeicao_disponivel.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/horarios.dart';
import 'package:app_refeitorio/models/refeicao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../buscas/busca_refeicao_ativas.dart';
import '../componentes/appBar_app.dart';
import '../componentes/fora_de_horario.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  bool validarefeicao = retornaValidadoRefeicao();
  Refeicao refeicaoDisponivel = retornaRefeicaoDisponivel();
  
  Horarios horarioDeAlmoco = retornaHorarioAlomco();
  Horarios horarioDeJanta = retornaHorarioJanta();

  Aluno _alunoLogado =  retornaAluno();

  DateTime _horaAtual = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(retorna_first_name_aluno().toString(),style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AppBarApp()))
              );
            }, 
              icon: Icon(Icons.menu)
            )
          ],
          backgroundColor: Color.fromARGB(255, 6, 168, 90),
        ),
        body: SingleChildScrollView(
          child: RetornaPage()
        ) 
      )
    );
  }

  Widget RetornaPage(){// Essa função retorna ou não uma refeição disponível
    if(!validarefeicao){
      return ForaDeHorario();
    }
    if(validaAlmocoPrioridade() || validaJantaPrioridade()){
      return RefeicaoDisponivel();
    }else if((validaAlmocoNaoPrioridade() || validaJantaNaoPrioridade()) &&(validaHorarioAlmoco() || validaHorarioJanta())){
      return RefeicaoDisponivel();
    }else {
      return ForaDeHorario();
    }
  }

  bool validaAlmocoPrioridade(){//Valida se o aluno é ou não prioritário nessa refeição, e se ele está no horárioalmoço
    if(validarefeicao && refeicaoDisponivel.horario == horarioDeAlmoco.id && horarioDeAlmoco.turno_prioridade == _alunoLogado.turno){
      return true;
    }else{
      return false;
    }
  }

  bool validaJantaPrioridade(){//Valida se o aluno é ou não prioritário nessa refeição, e se ele está no horário de janta
    if(validarefeicao && refeicaoDisponivel.horario == horarioDeJanta.id && horarioDeJanta.turno_prioridade == _alunoLogado.turno){
      return true;
    }else{
      return false;
    }
  }
  
  bool validaAlmocoNaoPrioridade(){////Valida se um aluno não é priritário para o almoço
    if(validarefeicao && refeicaoDisponivel.horario == horarioDeAlmoco.id && horarioDeAlmoco.turno_prioridade != _alunoLogado.turno){
      return true;
    }else{
      return false;
    }
  }

  bool validaJantaNaoPrioridade(){//Valida se um aluno não é priritário para a janta
    if(validarefeicao && refeicaoDisponivel.horario == horarioDeJanta.id && horarioDeJanta.turno_prioridade != _alunoLogado.turno){
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
  }
}



