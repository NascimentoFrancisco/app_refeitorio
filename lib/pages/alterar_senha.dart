

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlterarSenha extends StatefulWidget {
  const AlterarSenha({Key? key}) : super(key: key);

  @override
  State<AlterarSenha> createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {

  TextEditingController _SenhaAntigaControler = TextEditingController();
  TextEditingController _SenhaControler = TextEditingController();
  TextEditingController _ConfirmSenhaControler = TextEditingController();

  final loading_pss = ValueNotifier<bool>(false);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Francisco'),
          backgroundColor: Color.fromARGB(255, 6, 168, 90),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Text('Alterar senha',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _SenhaAntigaControler,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Insira sua senha antiga',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 3
                      )
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 6, 168, 90)
                    )
                  ),
                ),
                const SizedBox(height: 8,),
                TextField(
                  controller: _SenhaControler,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Insira a nova senha',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 3
                      )
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 6, 168, 90)
                    )
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ConfirmSenhaControler,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirme sua nova senha',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 3
                      )
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 6, 168, 90)
                    )
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(onPressed: () {
                  loading_pss.value = !loading_pss.value;
                }, 
                  child: AnimatedBuilder(
                    animation: loading_pss,
                    builder: (context,_){
                      return loading_pss.value 
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white,),
                      )
                      :const Text('ALTERAR SENHA',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        );
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 6, 168, 90)
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}