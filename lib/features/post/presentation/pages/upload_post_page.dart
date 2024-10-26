import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubits.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_states.dart';
import '../../../auth/domain/entities/app_user.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  @override
  PlatformFile? imagePickedFile;
  Uint8List? webImage;
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
  //pickImage void

  void uploadPost(){
    if (imagePickedFile == null || textController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Both image and caption are required")));
      return;
    }
    final newPost = Post(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: currentUser!.uid,
        username: currentUser!.name,
        text: textController.text,
        imageUrl: '',
        timestamp: DateTime.now());
    final postCubit = context.read<PostCubit>();
    if (kIsWeb){
      postCubit.createPost(newPost,imageBytes: imagePickedFile?.bytes);
    }else{
      postCubit.createPost(newPost, imagePath: imagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        builder: (context, state){
          if (state is PostsLoading || state is PostsUpLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }
          return buildUploadPage();
        },
        listener: listener)
  }
}
