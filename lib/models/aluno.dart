class Aluno{
  int id;//Sempre int
  String nome;
  String rg;
  DateTime data_nascimento;//Sempre datetime
  String turno;
  String sexo;
  String telefone;
  int pendencias;//Sempre inteiro

  Aluno({
    required this.id,
    required this.nome,
    required this.rg,
    required this.data_nascimento,
    required this.turno,
    required this.sexo,
    required this.telefone,
    required this.pendencias,
  });

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'nome':nome,
      'rg':rg,
      'data_nascimento':data_nascimento.toString(),
      'turno':turno,
      'sexo':sexo,
      'telefone':telefone,
      'pendencias':pendencias.toString()
    };
  }
}