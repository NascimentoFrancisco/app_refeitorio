class User{
  /*Essa classe pode ser usada tanto para GET quanto para  PUT/PATCH*/
  int id;
  String username;
  String email;
  

  User({required this.id, 
    required this.username,
    required this.email,
  });

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'username':username,
      'email':email,
    };
  }

}