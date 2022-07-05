import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/repositorios/pega_data_hora_atual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';


class SemCardapio extends StatefulWidget {
  const SemCardapio({Key? key}) : super(key: key);

  @override
  State<SemCardapio> createState() => _SemCardapioState();
}

class _SemCardapioState extends State<SemCardapio> {

  Aluno alunolog = retornaAluno();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(alunolog.turno == 'M'?'Manhã':'Tarde',
            style: TextStyle(color: Colors.black,fontSize: 16),
          ),
          const SizedBox(height: 8.0,),
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color.fromARGB(255, 252, 239, 56)
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('NÃO HÁ CARDÁPIO CADASTRADO PARA HOJE',
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0,),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color.fromARGB(255, 245, 227, 144)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Você não reservou janta para hoje',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0,),
          Text('Data de hoje: ${DateFormat('dd/MM/yyyy - HH:mm').format(PegaDataHoje())}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14
            ),
          ),
        ],
      ),    
    );
  }
}