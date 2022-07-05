import 'package:flutter/material.dart';

void MostrarSobre(BuildContext context){
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Aplicativo android do sistema de Reservas de Refeição.'),
      content: const Text('Aplicativo desenvolvido por Francisco Leite do Nascimento aluno do módulo V do curso de Análise e Desenvolvimento de Sistemas.'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, 
          child: Text('FECHAR', style: TextStyle(color: Color.fromARGB(255, 2, 155, 40), fontSize: 16),)
        )
      ],    
    )
  );
}