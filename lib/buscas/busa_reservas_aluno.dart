import 'package:app_refeitorio/models/refeicao.dart';
import 'package:app_refeitorio/models/reservas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../autorizacao/autorizacao.dart';

List<Reservas>ListRservasDoAluno = [];

Future buscaReservasDeUmAluno(String nome_usuario,String senha,String id_aluno)async{
  //aluno/2/reservas
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);
  String url = 'https://refeitorio-cacor.herokuapp.com/aluno/$id_aluno/reservas';

  var response = await http.get(Uri.parse(url), 
  headers: <String,String>{'authorization':auth.BasicAuth()});

  //print(response.statusCode);
  //print(response.body);
  
  if(response.statusCode == 200 && response.body.isNotEmpty){
    List<dynamic> data = jsonDecode(response.body);
    data.forEach((element) {
      Reservas reserva = Reservas(
      id: element['id'], 
      data_reserva: DateTime.parse(element['data_reserva']).toLocal(), 
      aluno_reserva: element['aluno_reserva'], 
      refeicao_reservada: element['refeicao_reservada']);

      ListRservasDoAluno.add(reserva);  
    });
    
  }
  
}

List<Reservas> retornaRservasDoAluno(){
  return ListRservasDoAluno;
}


bool ValidaPossibilidadeRserva(int id_aluno,int id_refeicao){
  DateTime _dataHoje = DateTime.now();
  bool validator = true;
  int cont = 0;

  ListRservasDoAluno.forEach((element) { 
    print('${element.aluno_reserva} // $_dataHoje');
    if(element.aluno_reserva == id_aluno && element.refeicao_reservada == id_refeicao && element.refeicao_reservada == _dataHoje){
      cont ++;
    }
  });

  if(cont > 0){
    validator = false;
  }
  return validator;

}