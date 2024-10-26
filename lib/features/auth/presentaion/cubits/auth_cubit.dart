
import 'package:social_media_app/features/auth/presentaion/cubits/auth.states.dart';
import '../../domain/repos/auth_repo.dart';
import '../../domain/entities/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';



class AuthCubit extends Cubit<AuthState>{
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  void checkAuth() async{
    final AppUser? user = await authRepo.getCurrentUser();

    if(user!=null){
      _currentUser = user;
      emit(Authenticated(user));
    }
    else{
      emit(Unauthenticated());
    }
  }

  AppUser? get currentUser => _currentUser;

  //login w email + pw
  Future<void> login(String email, String pw) async{
    try{
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(email,pw);


      if(user != null){
        _currentUser=user;
        emit(Authenticated(user));
      }
      else{
        emit(Unauthenticated());
      }
    }
    catch(e){
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register w email + pw
  Future<void> register(String name, String email, String pw) async{
    try{
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailPassword(name,email,pw);

      if(user != null){
        _currentUser=user;
        emit(Authenticated(user));
      }
      else{
        emit(Unauthenticated());
      }
    }
    catch(e){
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async{
    authRepo.logout();
    emit(Unauthenticated());
  }
}