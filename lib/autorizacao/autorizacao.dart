import 'dart:convert';

class BasicAuths{
  String usuario;
  String senha;

  BasicAuths({
    required this.usuario,
    required this.senha
  });

  String BasicAuth(){
    /*Essa função retorna os dados de Basic Auth para acessar a API*/
    String username = usuario;
    String  password = senha;
    String basicAuth  = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    return basicAuth;
  }

}