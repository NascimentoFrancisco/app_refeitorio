import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/buscas/busca_horarios.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/horarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ForaDeHorario extends StatefulWidget {
  const ForaDeHorario({Key? key}) : super(key: key);

  @override
  State<ForaDeHorario> createState() => _ForaDeHorarioState();
}

class _ForaDeHorarioState extends State<ForaDeHorario> {

  List<Horarios> listaDeHorarios = retornaListaHorarios();

  String ALMOCO = 'ALMOÇO';
  String JANTA = 'JANTA';

  String Manha = "Manhã";
  String Tarde = "Tarde";

  Aluno _alunoLog = retornaAluno();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _alunoLog.turno == 'M'?'Manhã':'Tarde',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromARGB(255, 252, 239, 56)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Atenção! Fora do horário de reserva ou cancelamento de reserva',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0,),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color.fromARGB(255, 107, 192, 207)
                ),
                child: ListView.builder(
                  itemCount: listaDeHorarios.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text('${listaDeHorarios[index].categoria == 'A' ?ALMOCO:JANTA}: das ${DateFormat('HH:mm').format(listaDeHorarios[index].inicio_reserva_prioritario)} às ${DateFormat('HH:mm').format(listaDeHorarios[index].fim_reserva)} para alunos da ${listaDeHorarios[index].turno_prioridade == 'M' ?Manha:Tarde} e das ${DateFormat('HH:mm').format(listaDeHorarios[index].inicio_reserva)} às ${DateFormat('HH:mm').format(listaDeHorarios[index].fim_reserva)} para os demais turnos.'),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
