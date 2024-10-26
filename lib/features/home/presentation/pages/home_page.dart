import 'package:flutter/material.dart';
import 'package:social_media_app/features/home/presentation/components/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // post cubit
  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();

    // fetch all posts
    fetchAllPosts();
  }

  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),

        actions: [
          IconButton(
              onPressed: () {context.read<AuthCubit>().logout();},
              icon: const Icon(Icons.logout),)
        ],
      ),

      // DRAWER
      drawer: const MyDrawer(),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          // TODO: continue the program
        },
      )
    );
  }
}
