import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth.states.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentaion/pages/auth_page.dart';
import 'package:social_media_app/features/home/presentation/pages/home_page.dart';
import 'package:social_media_app/features/post/data/firebase_post_repo.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubits.dart';
import 'package:social_media_app/features/profile/data/firebase_profile_repo.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_app/features/storage/data/firebase_storage_repo.dart';

import 'package:social_media_app/themes/theme_cubit.dart';

class AppFlow extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final storageRepo = FirebaseStorageRepo();

  //profile repo
  final profileRepo = FirebaseProfileRepo();

  final firebasePostRepo = FirebasePostRepo();

  AppFlow({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        // profile cubit
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit(profileRepo: profileRepo, storageRepo: storageRepo),
        ),

        // post cubit
        BlocProvider<PostCubit>(create: (context) => PostCubit(postRepo: firebasePostRepo, storageRepo: storageRepo),
        ),

        //theme cubit
        BlocProvider<ThemeCubit>(create: (context)=> ThemeCubit()),
      ],

        // bloc builder: themes
        child: BlocBuilder<ThemeCubit,ThemeData>(
          builder:(context, currentTheme) =>MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: currentTheme,

            //bloc builder: check current auth state
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
              listener: (context, state) {
                if (state is AuthError){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message,
                        style: const TextStyle(fontFamily: 'Poppins'),)
                      ));
                }
              },
            ),
          ),
      )
    );
  }
}