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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira seu CPF',
                      hintText: '000.000.000-00',
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
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira sua senha',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 6, 168, 90))),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async{
                      var login = await buscarUser(_userController.text, _passwordController.text);
                      if(login){
                        Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => UserPage())
                        );
                      }else{
                        print('Dados errados');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 6, 168, 90)),
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
