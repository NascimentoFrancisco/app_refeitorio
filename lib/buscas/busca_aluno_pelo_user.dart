
import 'package:app_refeitorio/autorizacao/autorizacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/aluno.dart';
import 'busa_reservas_aluno.dart';

late Aluno _aluno;
String aluno_first_name = '';

Future buscaAlunoPeluUser(String nome_usuario,String senha,String id_user) async{
   
  String parametro = id_user;
  
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);

  String url = 'https://refeitorio-cacor.herokuapp.com/user/$parametro/aluno';

  var response = await http.get(Uri.parse(url), 
  headers: <String,String>{'authorization':auth.BasicAuth()});
  
  List<dynamic> data = jsonDecode(response.body);
  var aluno = data[0];
  //print(aluno);
  _aluno = Aluno(
    id: aluno['id'], 
    nome: aluno['nome'], 
    rg: aluno['rg'], 
    data_nascimento: DateTime.parse(aluno['data_nascimento']), 
    turno: aluno['turno'], 
    sexo: aluno['sexo'], 
    telefone: aluno['telefone'], 
    pendencias: aluno['pendencias']
  );

  List<String>lista = _aluno.nome.split(' ');
  aluno_first_name = lista[0];

  await buscaReservasDeUmAluno(nome_usuario, senha, _aluno.id.toString());

}

Aluno retornaAluno(){
  return _aluno;
}

String retorna_first_name_aluno(){
  return aluno_first_name;
}