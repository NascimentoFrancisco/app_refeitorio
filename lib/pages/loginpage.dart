// ignore_for_file: prefer_const_constructors

import 'package:app_refeitorio/buscas/busca_user.dart';
import 'package:app_refeitorio/pages/userpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //bool espera = false;
  final espera = ValueNotifier<bool>(false);

  bool get is_clicked => espera.value == true;

  String mensagem_de_erro = retorna_mensagem_erro();
  
  bool _obscured = false;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; 
      textFieldFocusNode.canRequestFocus = false;    
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Image(image: AssetImage('assets/images/logo.png')),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: _userController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira seu CPF',
                      hintText: '00000000000',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 6, 168, 90))),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscured,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira sua senha',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 6, 168, 90)),
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
                ElevatedButton( 
                     onPressed: efetua_login,
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 6, 168, 90)),
                    child: AnimatedBuilder(
                      animation: espera,
                      builder: (context, _){
                        return espera.value
                        ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                        :const Text('ENTRAR',
                          style: TextStyle(color: Colors.white, fontSize: 20),  
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
  void showerro(){
    setState(() {
      mensagem_de_erro=retorna_mensagem_erro();
    });
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem_de_erro),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, 
            child: const Text('Fechar'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      )
    );
  }

  void efetua_login()async{
    if(!is_clicked){
      espera.value = true; 
      var login = await buscarUser(_userController.text, _passwordController.text);
      if(login){
        espera.value = false; 
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => UserPage())
        );
      }else{
        espera.value = false; 
        showerro();
      }
    }
  }
}