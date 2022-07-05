
class Refeicao{
  int id;
  String tipo_da_refeicao;
  String cardapio;
  int quantidade;
  int quantidade_reservadas;
  int horario;
  DateTime data_oferta;
  String status;

  Refeicao({
    required this.id,
    required this.tipo_da_refeicao,
    required this.cardapio,
    required this.quantidade,
    required this.quantidade_reservadas,
    required this.horario,
    required this.data_oferta,
    required this.status
  });

  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'tipo_da_refeicao':tipo_da_refeicao,
      'cardapio':cardapio,
      'quantidade':quantidade,
      'quantidade_reservadas':quantidade_reservadas,
      'horario':horario,
      'data_oferta':data_oferta,
      'status':status
    };
  }
}