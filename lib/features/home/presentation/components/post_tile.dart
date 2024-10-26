import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/app.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubits.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../../post/domain/entities/post.dart';
import '../../../profile/domain/entities/profile_user.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;

  const PostTile({super.key, required this.post, required this.onDeletePressed});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late final postCubit = context.read<PostCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  bool isOwnPost = false;

  AppUser? currentUser;

  ProfileUser? postUser;


  void showOptions(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: const Text('Delete Post?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel")),
          TextButton(onPressed: () {
            widget.onDeletePressed!();
            Navigator.of(context).pop();},
              child: Text("Delete")),
        ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.post.username),
            IconButton(onPressed: widget.onDeletePressed,
                icon: const Icon(Icons.delete),
            )
          ],
        ),
        CachedNetworkImage(
          imageUrl: widget.post.imageUrl,
          height: 430,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(height: 430),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ],
    );
  }
}

