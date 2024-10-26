import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth.states.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentaion/pages/auth_page.dart';
import 'package:social_media_app/themes/light_mode.dart';

class AppFlow extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  const AppFlow({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return const AuthPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            }
            else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}