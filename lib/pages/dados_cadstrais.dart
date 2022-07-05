

import 'package:app_refeitorio/buscas/busca_aluno_pelo_user.dart';
import 'package:app_refeitorio/buscas/busca_user.dart';
import 'package:app_refeitorio/models/aluno.dart';
import 'package:app_refeitorio/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({Key? key}) : super(key: key);

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {

  Color _corFundoDados = Color.fromARGB(255, 227, 238, 238);
  User _userlog = retornaUsuario();
  Aluno _alunolog = retornaAluno();


  String _sexoMasculino = "Masculino";
  String _sexoFeminino = "Feminino";

  String _tarde = 'Tarde';
  String _manha='Manhã';
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Francisco'),
          backgroundColor: Color.fromARGB(255, 6, 168, 90),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Nome Completo: ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text('${_alunolog.nome}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Email:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text('${_userlog.email}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Telefone:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text('${_alunolog.telefone}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Sexo:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text(_alunolog.sexo == 'M' ? _sexoMasculino:_sexoFeminino,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('CPF:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text('${_userlog.username}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Data de Nascimento:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text(DateFormat('dd/MM/yyyy').format(_alunolog.data_nascimento),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Turno:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text( _alunolog.turno == "M" ? _manha:_tarde,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _corFundoDados
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Pendeências:',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text('${_alunolog.pendencias.toString()}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}