
import 'package:app_refeitorio/buscas/busa_reservas_aluno.dart';
import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/buscas/busca_refeicao_ativas.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/refeicao.dart';
import 'package:app_refeitorio/models/reservas.dart';
import 'package:app_refeitorio/repositorios/faz_reserva.dart';
import 'package:app_refeitorio/repositorios/pega_data_hora_atual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class RefeicaoDisponivel extends StatefulWidget {
  const RefeicaoDisponivel({Key? key}) : super(key: key);

  @override
  State<RefeicaoDisponivel> createState() => _RefeicaoDisponivelState();
}

class _RefeicaoDisponivelState extends State<RefeicaoDisponivel> {

  Aluno alunoLog = retornaAluno();

  Refeicao _refeicaoDisponivel = retornaRefeicaoDisponivel();

  bool validarefeicao = retornaValidadoRefeicao();

  final loading = ValueNotifier<bool>(false);

  bool get is_clicked_confirm => loading.value == true;

  bool validacao = validaPossibilidadeRserva(retornaAluno().id,retornaRefeicaoDisponivel().id);

  Color cor_pode_reservar = Color.fromARGB(255, 2, 136, 71);
  Color cor_nao_pode_reservar = Color.fromARGB(255, 219, 8, 8);

  Color cor_texto_pode_reservar = Color.fromARGB(255, 219, 8, 8);
  Color cor_texto_nao_pode_reservar = Colors.black;

  Color cor_fundo_pode_reservar = Color.fromARGB(255, 245, 227, 144);
  Color cor_fundo_nao_pode_reservar = Color.fromARGB(255, 20, 184, 184);

  String texto_nao_reserva = 'Você não reservou sua refeição.';
  String texto_esta_reserva = 'Sua refeição foi reservada.';

  String texto_butao_reservar = 'SOLICITAR RESERVA';
  String texto_butao_cancelar_reserva = 'CANCELAR RESERVA'; 

  String texto_confirma_reservar = 'Confirma a reserva da refeiçao?';
  String texto_confirma_cancelamento_reservar = 'Confirma o cancelamento de reserva da refeiçao?';

  String reservas_esgotadas = '';
  bool valida_reserva_esgotadas = false;

  //Relativo a reservas
  bool situacao_reserva = retorna_resultado_reserva();
  String mesnagem_erro_acerto_reseva = retorna_mensagem_erro_reserva();

  Reservas? reserva_do_aluno = retorna_reserva_aluno_log();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(alunoLog.turno == 'M'?'Manhã':'Tarde',
              style: TextStyle(color: Colors.black,fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Limite de reservas: ${_refeicaoDisponivel.quantidade}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text('Quantidade de reservas feitas: ${_refeicaoDisponivel.quantidade_reservadas}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ), 
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromARGB(255, 238, 247, 195)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Cardápio de hoje:',
                      style: TextStyle(color: Colors.black,fontSize: 16),
                    ),
                    Text('${_refeicaoDisponivel.cardapio}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Refeição: ${_refeicaoDisponivel.tipo_da_refeicao == 'A' ?'Almoço':'Janta'}',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: validacao ? cor_fundo_pode_reservar:cor_fundo_nao_pode_reservar
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(validacao ? texto_nao_reserva:texto_esta_reserva,
                  style: TextStyle(color: validacao ? cor_texto_pode_reservar:cor_texto_nao_pode_reservar),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Data de hoje: ${DateFormat('dd/MM/yyyy - HH:mm').format(PegaDataHoje())}',
              style: TextStyle(color: Colors.black, fontSize: 14
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: valida_reserva_pela_quantidade() ?
              ShowConfirmReserva:null, 
              child: Text(validacao ? texto_butao_reservar:texto_butao_cancelar_reserva,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                primary: validacao ?cor_pode_reservar:cor_nao_pode_reservar
              ),
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: valida_reserva_esgotadas?cor_nao_pode_reservar:Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(reservas_esgotadas,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void ShowConfirmReserva(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(validacao ?'Confirmação de reserva':'Confirmação de cancelamento de reserva'),
        content: Text(validacao ?texto_confirma_reservar:texto_confirma_cancelamento_reservar),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, 
            child: const Text('Fechar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
          TextButton(
            child: AnimatedBuilder(
              animation: loading,
              builder: (context, _){
                return loading.value 
                  ?const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(color: Colors.green,),
                  )
                  :const Text('Confirmar');
              },
            ),
            style: TextButton.styleFrom(primary: Colors.green),
             onPressed: efetua_cancela_reserva
          ),
        ],
      )
    );
  }

  void showerro(){
    setState(() {
      mesnagem_erro_acerto_reseva = retorna_mensagem_erro_reserva();
    });
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Atenção!'),
        content: Text(mesnagem_erro_acerto_reseva),
        actions: [
          TextButton(onPressed: () { 
            setState(() {
              _refeicaoDisponivel = retorna_nova_refeicao_disponivel();
              reserva_do_aluno = retorna_nova_reserva();
            });
            loading.value = false;
            Navigator.of(context).pop();
          }, 
            child: const Text('Fechar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      )
    );
  }

  Future efetua_cancela_reserva()async{
    if(!is_clicked_confirm){
      loading.value = true;
      if(validacao){
        await faz_reserva(alunoLog.id,_refeicaoDisponivel.id);
        setState(() {
          situacao_reserva = retorna_resultado_reserva();
        });
        if(situacao_reserva){
          setState(() {
            _refeicaoDisponivel = retorna_nova_refeicao_disponivel();
            mesnagem_erro_acerto_reseva = retorna_mensagem_erro_reserva();
            validacao = false;
          });
        }else{
          setState(() {
            validacao = false;
          });
        }
        Navigator.of(context).pop();
        showerro();
      }else{
        //Cancelar reserva
        await cancela_reserva(reserva_do_aluno!.id);
        setState(() {
          situacao_reserva = retorna_resultado_reserva();
        });
        if(!situacao_reserva){
          _refeicaoDisponivel = retorna_nova_refeicao_disponivel();
          mesnagem_erro_acerto_reseva = retorna_mensagem_erro_reserva();
          validacao = true;
        }
        Navigator.of(context).pop();
          showerro();
      }
    }
  }

  bool valida_reserva_pela_quantidade(){//Precisa alterarisso ainda
    if(_refeicaoDisponivel.quantidade_reservadas >= _refeicaoDisponivel.quantidade && validacao){
      valida_reserva_esgotadas = true;
      reservas_esgotadas = 'RESERVAS ESGOTADAS :(';
      return false;
    }
    return true;
  }
}