

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../buscas/busa_reservas_aluno.dart';
import '../buscas/busca_aluno_pelo_user.dart';
import '../buscas/busca_horarios.dart';
import '../repositorios/alterar_senha.dart';
import 'loginpage.dart';

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

  String mesnagem_troca_senha = retorna_mensagem();
  bool situacao_troca = retorna_situacao();
  bool validacao_troca_senha = false;
  bool _obscured = false;
  
  final textFieldFocusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(retorna_first_name_aluno().toString()),
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
                  obscureText: _obscured,
                  maxLength: 16,
                  decoration: InputDecoration(
                    labelText: 'Insira sua senha antiga',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 3
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 6, 168, 90)
                    ),
                    prefixIcon: Icon(Icons.lock_rounded,color: Color.fromARGB(255, 6, 168, 90),size: 24),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured 
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                              size: 24,
                              color: Color.fromARGB(255, 6, 168, 90),
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 8,),
                TextField(
                  controller: _SenhaControler,
                  obscureText: _obscured,
                  maxLength: 16,
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
                    ),
                    prefixIcon: Icon(Icons.lock_rounded,color: Color.fromARGB(255, 6, 168, 90),size: 24),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured 
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                              size: 24,
                              color: Color.fromARGB(255, 6, 168, 90),
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ConfirmSenhaControler,
                  obscureText: _obscured,
                  maxLength: 16,
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
                    ),
                    prefixIcon: Icon(Icons.lock_rounded,color: Color.fromARGB(255, 6, 168, 90),size: 24),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured 
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                              size: 24,
                              color: Color.fromARGB(255, 6, 168, 90),
                          ),
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(onPressed: ()async {
                  loading_pss.value = true;
                  await efetua_troca_senha(_SenhaAntigaControler.text,_SenhaControler.text,_ConfirmSenhaControler.text);
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

  void showerro(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Atenção!'),
        content: Text(mesnagem_troca_senha),
        actions: [
          TextButton(onPressed: () {
            loading_pss.value = false; 
            Navigator.of(context).pop();
          }, 
            child: const Text('Fechar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      )
    );
  }

  Future efetua_troca_senha(String senha_antiga, String senha_nova, String confirm_senha)async{
    if(senha_nova != confirm_senha){
      setState(() {
        mesnagem_troca_senha = 'Nova senha diferente da confirmação de senha!';    
      });
      showerro();
    }else if(senha_nova == senha_antiga || senha_antiga == confirm_senha){
       setState(() {
        mesnagem_troca_senha = 'Nova senha ou a confirmação de senha igual a senha antiga!';    
      });
      showerro();
    }else{
      await alterar_a_senha(senha_antiga,senha_nova);
      setState(() {
        mesnagem_troca_senha = retorna_mensagem();
        validacao_troca_senha = retorna_situacao();
      });
      //showerro();
      if(validacao_troca_senha){
        limpa_lista_horarios();
        limpa_lista_reservas();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => LoginPage())
        );
      }
    }
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; 
      textFieldFocusNode.canRequestFocus = false;     
    });
  }
}