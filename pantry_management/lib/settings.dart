import 'package:flutter/material.dart';
import 'package:pantry_management/home/menu.dart';

void main() => runApp(const Settings());

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Container(width:250, child: userMenu(context)),
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Center(
          child: Text('Settings'),
        ),
      ),
    );
  }
}