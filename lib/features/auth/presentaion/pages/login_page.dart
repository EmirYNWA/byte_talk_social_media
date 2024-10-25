import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentaion/components/my_button.dart';
import 'package:social_media_app/features/auth/presentaion/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    Icons.lock_open_rounded,
                    size: 80,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 25,),
                Text("Welcome back!", style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                ),),
                const SizedBox(height: 40,),
                MyTextField(
                    controller: emailController, 
                    hintText: "Email", 
                    obscureText: false),
                const SizedBox(height: 10,),
                MyTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true),
                const SizedBox(height: 25,),
                MyButton(onTap: () {}, text: "Login",),
                const SizedBox(height: 25,),
                Text("Not a member? Register now")
              ],
            ),
          ),
        ),
      ),

    );
  }
}
