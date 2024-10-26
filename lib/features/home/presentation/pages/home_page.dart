import 'package:flutter/material.dart';
import 'package:social_media_app/features/home/presentation/components/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/app.dart';
import 'package:social_media_app/features/auth/presentaion/cubits/auth_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),

        actions: [
          IconButton(onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder:(context) => UploadPostPage())),
              icon: const Icon(Icons.add)),

        ],
      ),

      // DRAWER
      drawer: const MyDrawer(),

    );
  }
}
