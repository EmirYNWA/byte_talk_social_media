import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/app.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubits.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentaion/cubits/auth_cubit.dart';
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

  // on startup
  @override
  void initState() {
    super.initState();

    getCurrentUser();
    fetchPostUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    isOwnPost = (widget.post.userId == currentUser!.uid);
  }

  Future<void> fetchPostUser() async {
    final fetchedUser = await profileCubit.getUserProfile(widget.post.userId);
    if (fetchedUser!= null){
      setState(() {
        postUser = fetchedUser;
      });
    }
  }


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
    return  Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                postUser?.profileImageUrl != null ? CachedNetworkImage(
                  imageUrl: postUser!.profileImageUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.person),
                  imageBuilder: (context, ImageProvider) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: ImageProvider, fit: BoxFit.cover),
                    ),
                  ),
                )
                    : const Icon(Icons.person),

                const SizedBox(width: 15,),

                Text(widget.post.username),

                const Spacer(),
                if(isOwnPost)
                  GestureDetector(
                    onTap: showOptions,
                    child: const Icon(Icons.delete),
                  )
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl: widget.post.imageUrl,
            height: 430,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(height: 430),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                  Icon(Icons.favorite_border),
                  Text(" "),
                  Text("0"),


                  Icon(Icons.comment),
                  Text(" "),
                  Text("0"),
                const Spacer(),

                Text(widget.post.timestamp.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

