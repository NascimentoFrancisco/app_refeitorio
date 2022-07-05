
class Reservas{
  int id;
  DateTime data_reserva;
  int aluno_reserva;
  int refeicao_reservada;

  Reservas({
    required this.id,
    required this.data_reserva,
    required this.aluno_reserva,
    required this.refeicao_reservada,
  });

  Map<String,dynamic> toJason(){
    return {
      'id':id,
      'data_reserva':data_reserva,
      'aluno_reserva':aluno_reserva,
      'refeicao_reservada':refeicao_reservada
    };
  }
}