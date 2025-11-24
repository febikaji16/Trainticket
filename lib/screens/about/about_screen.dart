import 'package:flutter/material.dart';
import 'package:trainticket/screens/home/widgets/app_drawer.dart';
import 'package:trainticket/widgets/left_back_menu_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LeftBackMenuAppBar(title: 'About'),
      drawer: const AppDrawer(),
      body: const Center(child: Text('About screen (placeholder)')),
    );
  }
}
