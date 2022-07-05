
import 'package:app_refeitorio/autorizacao/autorizacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/aluno.dart';
import 'busa_reservas_aluno.dart';

late Aluno _aluno;

Future buscaAlunoPeluUser(String nome_usuario,String senha,String id_user) async{
   
  String parametro = id_user;

  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);

  //Url tem que ser alterada
  String url = 'https://refeitorio-cacor.herokuapp.com/user/$parametro/aluno';
  print('Inicio');
  var response = await http.get(Uri.parse(url), 
  headers: <String,String>{'authorization':auth.BasicAuth()});
  
  //print(response.statusCode);
  //print(response.body);

  //Essa parte comentada será alterada depois, tudo fará parte de um try/cath
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

  await buscaReservasDeUmAluno(nome_usuario, senha, _aluno.id.toString());

}

Aluno retornaAluno(){
  return _aluno;
}