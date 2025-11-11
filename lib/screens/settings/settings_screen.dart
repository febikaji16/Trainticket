import 'package:flutter/material.dart';
import 'package:trainticket/screens/home/widgets/app_drawer.dart';
import 'package:trainticket/widgets/left_back_menu_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LeftBackMenuAppBar(title: 'Settings'),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Settings screen (placeholder)')),
    );
  }
}
