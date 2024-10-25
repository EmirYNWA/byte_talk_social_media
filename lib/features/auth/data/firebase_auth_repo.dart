class FirebaseAuthRepo implements AuthRepo {
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password){
    throw UninplementedError();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name,String email, String password){
    throw UninplementedError();
  }

  @override
  Future<void> logout(String name,String email, String password){
    throw UninplementedError();
  }

  @override
  Future<AppUser?> getCurrentUser(){
    throw UninplementedError();
  }
}
