class AppUser {
  final String uid;
  //final String username;
  final String name;
 // final String lastname;
  final String email;
  // final String password;

  AppUser({
    required this.uid,
    //required this.username,
    required this.name,
   // required this.lastname,
    required this.email,
    // required this.password,

  });

  Map<String, dynamic> toJson() {
    return{
      'uid': uid,
      // 'username': username,
      'name': name,
      // 'lastname': lastname,
      'email': email,
      // 'password': password,
    };
  }
  factory AppUser.fromJson(Map<String, dynamic> jsonUser){
    return AppUser(
        uid: jsonUser ['uid'],
        // username: jsonUser ['username'],
        name: jsonUser ['name'],
        // lastname: jsonUser ['lastname'],
        email: jsonUser ['email'],
        // password: jsonUser ['password'],
    );
  }
}