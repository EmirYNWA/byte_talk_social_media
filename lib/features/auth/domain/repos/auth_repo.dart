import 'package:social_media_app/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassoword(
      String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}