
class Horarios{
  int id;
  String categoria;
  String turno_prioridade;
  DateTime inicio_reserva_prioritario;
  DateTime inicio_reserva;
  DateTime fim_reserva;

  Horarios({
    required this.id,
    required this.categoria,
    required this.turno_prioridade,
    required this.inicio_reserva_prioritario,
    required this.inicio_reserva,
    required this.fim_reserva,
  });
}