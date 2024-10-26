import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/app.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';

import '../../../auth/domain/entities/app_user.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  @override
  PlatformFile? imagePickedFile;
  Uint8List webImage;
  final textController = TextEditingController();

  AppUser? currentUser;

  @override
  void initState() {

    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),


    );
  }
}
