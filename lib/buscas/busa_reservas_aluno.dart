import 'package:app_refeitorio/models/refeicao.dart';
import 'package:app_refeitorio/models/reservas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../autorizacao/autorizacao.dart';

List<Reservas>ListRservasDoAluno = [];
DateTime _dataHoje = DateTime.now();

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


bool validaPossibilidadeRserva(int id_aluno,int id_refeicao){
  DateTime _dataHoje = DateTime.now();
  bool validator = true;
  int cont = 0;

  ListRservasDoAluno.forEach((element) { 
    print('Reserva do aluno ${element.aluno_reserva} // Data hoje:$_dataHoje // Data reserva: ${element.data_reserva}');
    if(element.aluno_reserva == id_aluno && element.refeicao_reservada == id_refeicao && valida_data_da_reserva(element.data_reserva)){
      cont ++;
    }
  });

  if(cont > 0){
    validator = false;
  }
  print(validator);
  return validator;

}

bool valida_data_da_reserva(DateTime data_reserva){
  if(_dataHoje.year == data_reserva.year && _dataHoje.month == data_reserva.month && _dataHoje.day == data_reserva.day){
    return true;
  }
  return false;
}