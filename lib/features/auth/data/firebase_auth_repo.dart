import '../domain/entities/app_user.dart';
import '../domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password){
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name,String email, String password){
    throw UnimplementedError();
  }

  @override
  Future<void> logout(){
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> getCurrentUser(){
    throw UnimplementedError();
  }
}
