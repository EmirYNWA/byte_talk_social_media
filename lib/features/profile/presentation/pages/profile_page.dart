import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentaion/cubits/auth_cubit.dart';
    
    class ProfilePage extends StatefulWidget {
      final String uid;
      const ProfilePage({super.key, required this.uid});
    
      @override
      State<ProfilePage> createState() => _ProfilePageState();
    }
    
    class _ProfilePageState extends State<ProfilePage> {
      // cubits
      late final authCubit = context.read<AuthCubit>();
      late final profileCubit = context.read<ProfileCubit>();
      // current user
      late AppUser? currentUser = authCubit.currentUser;

      // on startup
      @override
      void initState(){
        super.initState();
        
        //load user profile data
        profileCubit.fetchUserProfile(widget.uid);
      }
      // BUILD UI
      @override
      Widget build(BuildContext context) {
        return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state){
              // loaded
               if(state is ProfileLoaded){
                 return Scaffold(
                   //APP BAR
                   appBar: AppBar(
                     title: Text(currentUser!.email),
                     foregroundColor: Theme.of(context).colorScheme.primary,
                   ),
                   // BODY
                 );
               }
              // loading..
              else if (state is ProfileLoading){
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
               } else{
                return const Center(child: Text("No profile found.."),
                );
               }
            },
        );
      }
    }
    