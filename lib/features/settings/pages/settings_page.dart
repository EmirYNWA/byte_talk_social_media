import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/theme_cubit.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // theme cubit
    final themeCubit = context.watch<ThemeCubit>();

    // is dark mode
    bool isDarkMode = themeCubit.isDarkMode;

    // SCAFFOLD
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ), // AppBar
      body: Column(
        children: [
          // dark mode tile
          ListTile(
            title: Text("Dark Mode"),
            trailing: CupertinoSwitch(
                value: isDarkMode,
                onChanged: (value) {
                  themeCubit.toggleTheme();
                },
            )
          )
        ],
      ), // Column
    ); // Scaffold
  }
}