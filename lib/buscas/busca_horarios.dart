import 'package:app_refeitorio/models/horarios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//
import '../autorizacao/autorizacao.dart';

List<Horarios>ListHorarios = [];

late Horarios horarioAlmoco;
late Horarios horarioJanta;

Future buscaHorarios(String nome_usuario,String senha) async{
  BasicAuths auth = BasicAuths(usuario: nome_usuario, senha: senha);
  String url = 'https://refeitorio-cacor.herokuapp.com/horarios/';

  var response = await http.get(Uri.parse(url), 
  headers: <String,String>{'authorization':auth.BasicAuth()});

  List<dynamic> data = jsonDecode(response.body);

  data.forEach((element) { 
    Horarios horario = Horarios(
      id: element['id'], 
      categoria: element['categoria'], 
      turno_prioridade: element['turno_prioridade'], 
      inicio_reserva_prioritario:DateTime.parse(element['inicio_reserva_prioritario']).toLocal(), 
      inicio_reserva: DateTime.parse(element['inicio_reserva']).toLocal(), 
      fim_reserva: DateTime.parse(element['fim_reserva']).toLocal());

      ListHorarios.add(horario);
  });
}


List<Horarios> retornaListaHorarios(){
  return ListHorarios;
}

Horarios retornaHorarioAlomco(){
  ListHorarios.forEach((element) { 
    if(element.categoria == "A"){
      horarioAlmoco = Horarios(
      id: element.id, 
      categoria: element.categoria, 
      turno_prioridade: element.turno_prioridade, 
      inicio_reserva_prioritario: element.inicio_reserva_prioritario, 
      inicio_reserva: element.inicio_reserva, 
      fim_reserva: element.fim_reserva);
      }
  });
  return horarioAlmoco;
}

Horarios retornaHorarioJanta(){
  ListHorarios.forEach((element) { 
    if(element.categoria == "J"){
      horarioAlmoco = Horarios(
      id: element.id, 
      categoria: element.categoria, 
      turno_prioridade: element.turno_prioridade, 
      inicio_reserva_prioritario: element.inicio_reserva_prioritario, 
      inicio_reserva: element.inicio_reserva, 
      fim_reserva: element.fim_reserva);
      };
    });
  return horarioAlmoco;
}

void limpa_lista_horarios(){
  if(ListHorarios.isNotEmpty){
    ListHorarios = [];
  }
}
