import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentaion/components/my_button.dart';
import 'package:social_media_app/features/auth/presentaion/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 15),
                Text(
                  "Create an account!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),

                // Username field
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Name field
                MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Lastname field
                MyTextField(
                  controller: lastnameController,
                  hintText: "Last Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Surname field
                MyTextField(
                  controller: surnameController,
                  hintText: "Surname",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // Confirm Password field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // Register button
                MyButton(
                  onTap: () {
                    // Add registration logic here
                  },
                  text: "Register",
                ),
                const SizedBox(height: 25),

                // Already a member?
                Text(
                  "Already a member? Login now",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
