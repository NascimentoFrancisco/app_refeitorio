
import 'package:app_refeitorio/buscas/busa_reservas_aluno.dart';
import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/buscas/busca_refeicao_ativas.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/refeicao.dart';
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
  String texto_confirma_cancelamento_reservar = 'Confirma o cancelamento reserva da refeiçao?';

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
            ElevatedButton(onPressed: () {
              ShowConfirmReserva();
            }, 
              child: Text(validacao ? texto_butao_reservar:texto_butao_cancelar_reserva,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                primary: validacao ?cor_pode_reservar:cor_nao_pode_reservar
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
            child: const Text('Cancelar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, 
            child: const Text('Confirmar'),
            style: TextButton.styleFrom(primary: Colors.green),
          ),
        ],
      )
    );
  }
}